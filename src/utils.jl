abstract type _HTTP_METHOD end
abstract type _HTTP_METHOD_GET <: _HTTP_METHOD end
abstract type _HTTP_METHOD_DELETE <: _HTTP_METHOD end
abstract type _HTTP_METHOD_POST <: _HTTP_METHOD end
print(io::IO, ::Type{_HTTP_METHOD_GET}) = print(io, "GET")
print(io::IO, ::Type{_HTTP_METHOD_DELETE}) = print(io, "DELETE")
print(io::IO, ::Type{_HTTP_METHOD_POST}) = print(io, "POST")

function _sign(signature::String, data::String)
    return base64encode(hmac_sha256(Vector{UInt8}(signature), data))
end

function _generate_headers(
    api_data::ApiData,
    http_method_type::Type{T},
    endpoint_path::String,
    request_data::String,
) where {T<:_HTTP_METHOD}
    ts_str = string(round(Int64, time() * 1000))
    str_to_sign = "$ts_str$http_method_type$endpoint_path$request_data"
    return (
        "KC-API-SIGN" => _sign(api_data.secret, str_to_sign),
        "KC-API-TIMESTAMP" => ts_str,
        "KC-API-KEY" => api_data.key,
        "KC-API-PASSPHRASE" => api_data.encrypted_passphrase,
        "KC-API-KEY-VERSION" => 2,
        "Content-Type" => "application/json",
    )
end

function _create_api_uri(endpoint_path::String, query::String)
    return URI(; scheme="https", host="api.kucoin.com", path=endpoint_path, query=query)
end

function _create_api_uri(endpoint_path::String)
    return URI(; scheme="https", host="api.kucoin.com", path=endpoint_path)
end

function _handle(response::Response)::Union{JSON3.Array{JSON3.Object},JSON3.Object}
    iserror(response) && error(response.body)
    data = JSON3.read(response.body)
    if haskey(data, "code")
        data["code"] == "200000" || error(JSON3.write(data))
        return data["data"]
    end
    return data
end

function _kucoin_request(
    http_method_type::Type{T}, endpoint_path::String; kw...
) where {T<:_HTTP_METHOD}
    query_str = join("$argument=$value" for (argument, value) ∈ kw if value ≢ nothing)
    uri = _create_api_uri(endpoint_path, query_str)
    return request(http_method_type, uri; query=query_str)
end

function _kucoin_request(
    api_data::ApiData,
    http_method_type::Union{Type{_HTTP_METHOD_GET},Type{_HTTP_METHOD_DELETE}},
    endpoint_path::String;
    kw...,
)
    query_str = join(
        ("$argument=$value" for (argument, value) ∈ kw if value ≢ nothing), "&"
    )
    uri = _create_api_uri(endpoint_path, query_str)
    request_data = isempty(query_str) ? "" : "?$query_str"
    headers = _generate_headers(api_data, http_method_type, endpoint_path, request_data)
    return request(http_method_type, uri; query=query_str, headers=headers)
end

function _kucoin_request(
    api_data::ApiData,
    http_method_type::Type{_HTTP_METHOD_POST},
    endpoint_path::String;
    kw...,
)
    uri = _create_api_uri(endpoint_path)
    json_str = JSON3.write(kw)
    headers = _generate_headers(api_data, http_method_type, endpoint_path, json_str)
    return request(http_method_type, uri; body=json_str, headers=headers)
end

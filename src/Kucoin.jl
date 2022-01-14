module Kucoin

using HTTP: Response, URI, request, iserror
using SHA: hmac_sha256
using JSON3: JSON3, read, write
using Base64: base64encode
import Base: string

export KucoinApiData
export get_symbols_list
export list_accounts
export place_limit_order
export place_market_order

"""
    KucoinApiData

# Fields
- `key::String`: kucoin api key
- `secret::String`: kucoin api secret
- `passphrase::String`: kucoin api passphrase
- `encrypted_passphrase::String`: encrypted passpharase
"""
Base.@kwdef struct KucoinApiData
    key::String
    secret::String
    passphrase::String
    encrypted_passphrase::String = _sign(secret, passphrase)
end

"""
    KucoinRestApi.get_symbols_list([; market]) -> JSON3.Array{JSON3.Object}

See Kucoin official [docs](https://docs.kucoin.com/#get-symbols-list) for more details.


# Keywords
- `market::String`: [Optional] a name of the trading market 

# Returns
- `JSON3.Array{JSON3.Object}`: a list of symbols for all or a specified markets
```json
[
  ...
  {
    "symbol": "XLM-USDT",
    "name": "XLM-USDT",
    "baseCurrency": "XLM",
    "quoteCurrency": "USDT",
    "feeCurrency": "USDT",
    "market": "USDS",
    "baseMinSize": "0.1",
    "quoteMinSize": "0.01",
    "baseMaxSize": "10000000000",
    "quoteMaxSize": "99999999",
    "baseIncrement": "0.0001",
    "quoteIncrement": "0.000001",
    "priceIncrement": "0.000001",
    "priceLimitRate": "0.1",
    "isMarginEnabled": true,
    "enableTrading": true
  },
  ...
]
```
"""
function get_symbols_list(;
    market::Union{String,Nothing}=nothing
)::JSON3.Array{JSON3.Object}
    return _handle(_kucoin_request(_HTTP_METHOD_GET, "/api/v1/symbols"; market=market))
end

"""
    KucoinRestApi.list_accounts(api_data[; currency[, type]]) -> JSON3.Array{JSON3.Object}

See Kucoin official [docs](https://docs.kucoin.com/#list-accounts) for more details.

# Arguments
- `api_data::KucoinApiData`: holds api data susch as api key, secret, passphrase, etc.

# Keywords
- `currency::String`: [Optional] a unique currency kucoin code 
- `type::String`: [Optional] an account type, the valid values are: `"main"`, `"trade"`, 
`"margin"` or `"pool"`

# Returns
- `JSON3.Array{JSON3.Object}`
```json
[
  {
    "id": "5bd6e9286d99522a52e458de",  //accountId
    "currency": "BTC",  //Currency
    "type": "main",     //Account type, including main and trade
    "balance": "237582.04299",  //Total assets of a currency
    "available": "237582.032",  //Available assets of a currency
    "holds": "0.01099" //Hold assets of a currency
  },
  {
    "id": "5bd6e9216d99522a52e458d6",
    "currency": "BTC",
    "type": "trade",
    "balance": "1234356",
    "available": "1234356",
    "holds": "0"
}]
```
"""
function list_accounts(
    api_data::KucoinApiData;
    currency::Union{String,Nothing}=nothing,
    type::Union{String,Nothing}=nothing,
)::JSON3.Array{JSON3.Object}
    return _handle(
        _kucoin_request(
            api_data, _HTTP_METHOD_GET, "/api/v1/accounts"; currency=currency, type=type
        ),
    )
end

"""
    KucoinRestApi.place_limit_order(api_data[; kw...]) -> JSON3.Object

Place a limit order. See Kucoin official [docs](https://docs.kucoin.com/#place-a-new-order) 
for more details.

# Arguments
- `api_data::KucoinApiData`: holds api data susch as api key, secret, passphrase, etc.

# Keywords
- `price::String`: price per base currency in quote cuurency
- `size::String`: amount of base currency to buy or sell
- `time_in_force::String`: [Optional] `"GTC"`, `"GTT"`, `"IOC"`, or `"FOK"` (default is 
`"GTC"`), read [Time In Force](https://docs.kucoin.com/#time-in-force)
- `cancel_after::Int64`: [Optional] cancel after `n` seconds, requires `time_in_force` to 
be `"GTT"`
- `post_only::Bool`: [Optional] post only flag, invalid when `time_in_force` is 
`"IOC"` or `"FOK"`, read [Post Only](https://docs.kucoin.com/#post-only)
- `hidden::Bool`: [Optional] order will not be displayed in the order book
- `iceberg::Bool`: [Optional] only aportion of the order is displayed in the order book
- `visible_size::String`: [Optional] the maximum visible size of an iceberg order
- `client_order_id::String`: unique order id created by users to identify their orders, 
e.g. UUID
- `side::String`: `"buy"` or `"sell"`
- `symbol::String`: a valid trading symbol code. e.g. `"ETH-BTC"`
- `remark::String`: [Optional] remark for the order, length cannot exceed 100 utf-8 
characters
- `stp::String`: [Optional] self trade prevention, valid values: `"CN"`, `"CO"`, `"CB"` 
or `"DC"`, read [Self-Trade Prevention](https://docs.kucoin.com/#self-trade-prevention)

# Returns
- `JSON3.Object`
```json
{
  "orderId": "5bd6e9286d99522a52e458de"
}
```
"""
function place_limit_order(
    api_data::KucoinApiData;
    price::String,
    size::String,
    time_in_force::Union{String,Nothing}=nothing,
    cancel_after::Union{Int64,Nothing}=nothing,
    post_only::Union{Bool,Nothing}=nothing,
    hidden::Union{Bool,Nothing}=nothing,
    iceberg::Union{Bool,Nothing}=nothing,
    visible_size::Union{String,Nothing}=nothing,
    client_order_id::String,
    side::String,
    symbol::String,
    remark::Union{String,Nothing}=nothing,
    stp::Union{String,Nothing}=nothing,
)::JSON3.Object
    return _handle(
        _kucoin_request(
            api_data,
            _HTTP_METHOD_POST,
            "/api/v1/orders";
            price=price,
            size=size,
            timeInForce=time_in_force,
            cancelAfter=cancel_after,
            postOnly=post_only,
            hidden=hidden,
            iceberg=iceberg,
            visibleSize=visible_size,
            clientOid=client_order_id,
            side=side,
            symbol=symbol,
            type="limit",
            remark=remark,
            stp=stp,
        ),
    )
end

"""
    KucoinRestApi.place_market_order(api_data[; kw...]) -> JSON3.Object

Place a market order. See Kucoin official [docs](https://docs.kucoin.com/#place-a-new-order)
 for more details.

# Arguments
- `api_data::KucoinApiData`: holds api data susch as api key, secret, passphrase, etc.

# Keywords
- `size::String`: [Optional] desired amount in base currency. It is required that you use 
one of the two parameters, `size` or `funds`.
- `funds::String`: [Optional] the desired amount of quote currency to use. It is required 
that you use one of the two parameters, `size` or `funds`.
- `client_order_id::String`: unique order id created by users to identify their orders, 
e.g. UUID
- `side::String`: `"buy"` or `"sell"`
- `symbol::String`: a valid trading symbol code. e.g. `"ETH-BTC"`
- `remark::String`: [Optional] remark for the order, length cannot exceed 100 utf-8 
characters
- `stp::String`: [Optional] self trade prevention, valid values: `"CN"`, `"CO"`, `"CB"` 
or `"DC"`, read [Self-Trade Prevention](https://docs.kucoin.com/#self-trade-prevention)

# Returns
- `JSON3.Object`
```json
{
  "orderId": "5bd6e9286d99522a52e458de"
}
```
"""
function place_market_order(
    api_data::KucoinApiData;
    size::Union{String,Nothing}=nothing,
    funds::Union{String,Nothing}=nothing,
    client_order_id::String,
    side::String,
    symbol::String,
    remark::Union{String,Nothing}=nothing,
    stp::Union{String,Nothing}=nothing,
)::JSON3.Object
    return _handle(
        _kucoin_request(
            api_data,
            _HTTP_METHOD_POST,
            "/api/v1/orders";
            size=size,
            funds=funds,
            clientOid=client_order_id,
            side=side,
            symbol=symbol,
            type="market",
            remark=remark,
            stp=stp,
        ),
    )
end

function _sign(signature::String, data::String)
    return base64encode(hmac_sha256(Vector{UInt8}(signature), data))
end

function _generate_headers(
    api_data::KucoinApiData,
    http_method::String,
    endpoint_path::String,
    request_data::String,
)
    ts_str = string(round(Int64, time() * 1000))
    str_to_sign = "$ts_str$http_method$endpoint_path$request_data"
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
    data = read(response.body)
    if haskey(data, "code")
        data["code"] == "200000" || error(write(data))
        return data["data"]
    end
    return data
end

abstract type _HTTP_METHOD_GET end
abstract type _HTTP_METHOD_DELETE end
abstract type _HTTP_METHOD_POST end
string(::Type{_HTTP_METHOD_GET}) = "GET"
string(::Type{_HTTP_METHOD_DELETE}) = "DELETE"
string(::Type{_HTTP_METHOD_POST}) = "POST"

function _kucoin_request(
    http_method_type::Union{Type{_HTTP_METHOD_GET},Type{_HTTP_METHOD_DELETE}},
    endpoint_path::String;
    kw...,
)
    query_str = join("$argument=$value" for (argument, value) ∈ kw if value ≢ nothing)
    uri = _create_api_uri(endpoint_path, query_str)
    return request(string(http_method_type), uri; query=query_str)
end

function _kucoin_request(
    api_data::KucoinApiData,
    http_method_type::Union{Type{_HTTP_METHOD_GET},Type{_HTTP_METHOD_DELETE}},
    endpoint_path::String;
    kw...,
)
    query_str = join(
        ("$argument=$value" for (argument, value) ∈ kw if value ≢ nothing), "&"
    )
    uri = _create_api_uri(endpoint_path, query_str)
    http_method = string(http_method_type)
    request_data = isempty(query_str) ? "" : "?$query_str"
    headers = _generate_headers(api_data, http_method, endpoint_path, request_data)
    return request(http_method, uri; query=query_str, headers=headers)
end

function _kucoin_request(
    api_data::KucoinApiData,
    http_method_type::Type{_HTTP_METHOD_POST},
    endpoint_path::String;
    kw...,
)
    uri = _create_api_uri(endpoint_path)
    json_str = write(kw)
    http_method = string(http_method_type)
    headers = _generate_headers(api_data, http_method, endpoint_path, json_str)
    return request(http_method, uri; body=json_str, headers=headers)
end

end

"""
    Kucoin.list_accounts(api_data[; currency[, type]]) -> JSON3.Array{JSON3.Object}

Get a list of accounts. See Kucoin official [docs](https://docs.kucoin.com/#list-accounts) 
for more details.

# Arguments
- `api_data::UserApiData`: holds user API data susch as api key, secret, passphrase, etc.

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
    "type": "main",  //Account type, including main and trade
    "balance": "237582.04299",  //Total assets of a currency
    "available": "237582.032",  //Available assets of a currency
    "holds": "0.01099"  //Hold assets of a currency
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
    api_data::UserApiData;
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
    Kucoin.get_trade_fees(api_data; symbols) -> JSON3.Array{JSON3.Object}

Get the actual fee rate of the trading pair. See Kucoin official 
[docs](https://docs.kucoin.com/#actual-fee-rate-of-the-trading-pair) for more details.

# Arguments
- `api_data::UserApiData`: holds user API data susch as api key, secret, passphrase, etc.
- `symbols::AbstractVector{String}`: Trading pairs (optional, you can inquire fee rates of 
10 trading pairs each time at most)

# Returns
- `JSON3.Array{JSON3.Object}`
```json
[
  {
    "symbol": "BTC-USDT",
    "takerFeeRate": "0.001",
    "makerFeeRate": "0.001"
  },
  {
    "symbol": "KCS-USDT",
    "takerFeeRate": "0.002",
    "makerFeeRate": "0.0005"
}
```
"""
function get_trade_fees(
    api_data::UserApiData; symbols::AbstractVector{String}
)::JSON3.Array{JSON3.Object}
    return _handle(
        _kucoin_request(
            api_data, _HTTP_METHOD_GET, "/api/v1/trade-fees"; symbols=join(symbols, ",")
        ),
    )
end

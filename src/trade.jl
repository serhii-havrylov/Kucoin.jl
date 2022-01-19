"""
    Kucoin.place_limit_order(api_data[; <keyword arguments>]) -> JSON3.Object

Place a limit order. See Kucoin official [docs](https://docs.kucoin.com/#place-a-new-order) 
for more details.

# Arguments
- `api_data::UserApiData`: holds user API data susch as api key, secret, passphrase, etc.

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
- `trade_type::String`: [Optional] the type of trading `TRADE` (Spot Trade), `MARGIN_TRADE` 
(Margin Trade). Default is `TRADE`

# Returns
- `JSON3.Object`
```json
{
  "orderId": "5bd6e9286d99522a52e458de"
}
```
"""
function place_limit_order(
    api_data::UserApiData;
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
    trade_type::Union{String,Nothing}=nothing,
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
            tradeType=trade_type,
        ),
    )
end

"""
    Kucoin.place_market_order(api_data[; <keyword arguments>]]) -> JSON3.Object

Place a market order. See Kucoin official [docs](https://docs.kucoin.com/#place-a-new-order)
 for more details.

# Arguments
- `api_data::UserApiData`: holds user API data susch as api key, secret, passphrase, etc.

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
    api_data::UserApiData;
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

"""
    Kucoin.cancel_all_orders(api_data[; symbol[, trade_type]]]) -> Union{JSON3.Array{String},JSON3.Array{Union{}}}

Cancel all open orders. See Kucoin official 
[docs](https://docs.kucoin.com/#cancel-all-orders) for more details.

# Arguments
- `api_data::UserApiData`: holds user API data susch as api key, secret, passphrase, etc.

# Keywords
- `symbol::String`: [Optional] a valid symbol code for the trading pair
- `trade_type::String`: [Optional] the type of trading, cancel the orders for the specified 
trading type, and the default is to cancel the spot trading order (`TRADE`)

# Returns
- `Union{JSON3.Array{String},JSON3.Array{Union{}}}`: a list of ids of the canceled orders
```json
[
  "5c52e11203aa677f33e493fb",  //orderId
  "5c52e12103aa677f33e493fe",
  "5c52e12a03aa677f33e49401",
  "5c626b0803aa676fee8412a2"
]
```
"""
function cancel_all_orders(
    api_data::UserApiData;
    symbol::Union{String,Nothing}=nothing,
    trade_type::Union{String,Nothing}=nothing,
)::Union{JSON3.Array{String},JSON3.Array{Union{}}}
    return _handle(
        _kucoin_request(
            api_data,
            _HTTP_METHOD_DELETE,
            "/api/v1/orders";
            symbol=symbol,
            tradeType=trade_type,
        ),
    )["cancelledOrderIds"]
end

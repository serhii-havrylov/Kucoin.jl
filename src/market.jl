"""
    Kucoin.get_symbols_list([; market]) -> JSON3.Array{JSON3.Object}

Get a list of available currency pairs for trading. See Kucoin official 
[docs](https://docs.kucoin.com/#get-symbols-list) for more details.

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
    Kucoin.get_all_tickers() -> JSON3.Array{JSON3.Object}

Get the market information for all the trading pairs in the market. See Kucoin official 
[docs](https://docs.kucoin.com/#get-all-tickers) for more details.

# Returns
- `JSON3.Array{JSON3.Object}`
```json
[
  {
    "symbol": "BTC-USDT",  // symbol
    "symbolName":"BTC-USDT",  // Name of trading pairs, it would change after renaming
    "buy": "11328.9",  // bestAsk
    "sell": "11329",  // bestBid
    "changeRate": "-0.0055",  // 24h change rate
    "changePrice": "-63.6",  // 24h change price
    "high": "11610",  // 24h highest price
    "low": "11200",  // 24h lowest price
    "vol": "2282.70993217", // 24h volume，the aggregated trading volume in BTC
    "volValue": "25984946.157790431",  // 24h total, the trading volume in quote currency of last 24 hours
    "last": "11328.9",  // last price
    "averagePrice": "11360.66065903",  // 24h average transaction price yesterday
    "takerFeeRate": "0.001",  // Basic Taker Fee
    "makerFeeRate": "0.001",  // Basic Maker Fee
    "takerCoefficient": "1",  // Taker Fee Coefficient
    "makerCoefficient": "1"  // Maker Fee Coefficient
  }
]
```
"""
function get_all_tickers()::JSON3.Array{JSON3.Object}
    return _handle(_kucoin_request(_HTTP_METHOD_GET, "/api/v1/market/allTickers"))["ticker"]
end

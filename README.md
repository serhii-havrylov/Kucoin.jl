# Welcome to Kucoin.jl
This is a Julia wrapper for the Kucoin exchange [API](https://docs.kucoin.com).

## 🚧 Work In Progress! 🚧
### REST API
- [] add sandbox environment [docs_link](https://docs.kucoin.com/#sandbox)
#### User API
- [] user info [docs_link](https://docs.kucoin.com/#get-user-info-of-all-sub-accounts)
- [] create an account [docs_link](https://docs.kucoin.com/#get-user-info-of-all-sub-accounts)
- [x] list accounts [docs_link](https://docs.kucoin.com/#list-accounts)
- [] get an account [docs_link](https://docs.kucoin.com/#get-an-account)
- [] get account ledgers [docs_link](https://docs.kucoin.com/#get-account-ledgers)
- [] get account balance of a sub-account [docs_link](https://docs.kucoin.com/#get-account-balance-of-a-sub-account)
- [] get the aggregated balance of all sub-accounts [docs_link](https://docs.kucoin.com/#get-the-aggregated-balance-of-all-sub-accounts)
- [] get the transferable [docs_link](https://docs.kucoin.com/#get-the-transferable)
- [] transfer between master user and sub-user [docs_link](https://docs.kucoin.com/#transfer-between-master-user-and-sub-user)
- [] inner transfer [docs_link](https://docs.kucoin.com/#inner-transfer)
- [] create deposit address [docs_link](https://docs.kucoin.com/#create-deposit-address)
- [] get deposit addresses v2 [docs_link](https://docs.kucoin.com/#get-deposit-addresses-v2)
- [] get deposit addresses [docs_link](https://docs.kucoin.com/#get-deposit-address)
- [] get deposit list [docs_link](https://docs.kucoin.com/#get-deposit-list)
- [] get v1 historical deposits list [docs_link](https://docs.kucoin.com/#get-v1-historical-deposits-list)
- [] get withdrawals list [docs_link](https://docs.kucoin.com/#get-withdrawals-list)
- [] get v1 historical withdrawals list [docs_link](https://docs.kucoin.com/#get-v1-historical-withdrawals-list)
- [] get withdrawal quotas [docs_link](https://docs.kucoin.com/#get-withdrawal-quotas)
- [] apply withdraw [docs_link](https://docs.kucoin.com/#apply-withdraw-2)
- [] cancel withdraw [docs_link](https://docs.kucoin.com/#cancel-withdrawal)
- [] basic user fee [docs_link](https://docs.kucoin.com/#basic-user-fee)
- [x] actual fee rate of the trading pair [docs_link](https://docs.kucoin.com/#actual-fee-rate-of-the-trading-pair)
#### Trade API
- [x] place a new order [docs_link](https://docs.kucoin.com/#place-a-new-order)
- [] place a margin order [docs_link](https://docs.kucoin.com/#place-a-margin-order)
- [] place bulk orders [docs_link](https://docs.kucoin.com/#place-bulk-orders)
- [] cancel an order [docs_link](https://docs.kucoin.com/#cancel-an-order)
- [] cancel single order by clientOid [docs_link](https://docs.kucoin.com/#cancel-single-order-by-clientoid)
- [x] cancel all orders [docs_link](https://docs.kucoin.com/#cancel-all-orders)
- [] list orders [docs_link](https://docs.kucoin.com/#list-orders)
- [] get v1 historical orders list [docs_link](https://docs.kucoin.com/#get-v1-historical-orders-list)
- [] recent orders [docs_link](https://docs.kucoin.com/#recent-orders)
- [] get an order [docs_link](https://docs.kucoin.com/#get-an-order)
- [] get single active order by clientOid [docs_link](https://docs.kucoin.com/#get-single-active-order-by-clientoid)
- [] list fills [docs_link](https://docs.kucoin.com/#list-fills)
- [] recent fills [docs_link](https://docs.kucoin.com/#recent-fills)
- [] place a new stop order [docs_link](https://docs.kucoin.com/#place-a-new-order-2)
- [] cancel a stop order [docs_link](https://docs.kucoin.com/#cancel-an-order-2)
- [] cancel stop orders [docs_link](https://docs.kucoin.com/#cancel-orders)
- [] get a single stop order info [docs_link](https://docs.kucoin.com/#get-single-order-info)
- [] list stop orders [docs_link](https://docs.kucoin.com/#list-stop-orders)
- [] get a single stop order by clientOid [docs_link](https://docs.kucoin.com/#get-single-order-by-clientoid)
- [] cancel a single stop order by clientOid [docs_link](https://docs.kucoin.com/#cancel-single-order-by-clientoid-2)
#### Market data API
- [x] get symbols list [docs_link](https://docs.kucoin.com/#get-symbols-list)
- [] get ticker [docs_link](https://docs.kucoin.com/#get-ticker)
- [x] get all tickers [docs_link](https://docs.kucoin.com/#get-all-tickers)
- [] get 24hr stats [docs_link](https://docs.kucoin.com/#get-24hr-stats)
- [] get market list [docs_link](https://docs.kucoin.com/#get-market-list)
- [] get part order book aggregated [docs_link](https://docs.kucoin.com/#get-part-order-book-aggregated)
- [] get full order book aggregated [docs_link](https://docs.kucoin.com/#get-full-order-book-aggregated)
- [] get trade histories [docs_link](https://docs.kucoin.com/#get-trade-histories)
- [] get klines [docs_link](https://docs.kucoin.com/#get-klines)
- [] get currencies [docs_link](https://docs.kucoin.com/#get-currencies)
- [] get currency detail [docs_link](https://docs.kucoin.com/#get-currency-detail)
- [] get currency detail recommend [docs_link](https://docs.kucoin.com/#get-currency-detail-recommend)
- [] get fiat price [docs_link](https://docs.kucoin.com/#get-fiat-price)
- [] get fiat price [docs_link](https://docs.kucoin.com/#get-fiat-price)
#### Margin trade API
- [] get mark price [docs_link](https://docs.kucoin.com/#get-mark-price)
- [] get margin configuration info [docs_link](https://docs.kucoin.com/#get-margin-configuration-info)
- [] get margin account [docs_link](https://docs.kucoin.com/#get-margin-account)
- [] post borrow order [docs_link](https://docs.kucoin.com/#post-borrow-order)
- [] get borrow order [docs_link](https://docs.kucoin.com/#get-borrow-order)
- [] get repay record [docs_link](https://docs.kucoin.com/#get-repay-record)
- [] get repayment record [docs_link](https://docs.kucoin.com/#get-repayment-record)
- [] one click repayment [docs_link](https://docs.kucoin.com/#one-click-repayment)
- [] repay a single order [docs_link](https://docs.kucoin.com/#repay-a-single-order)
- [] post lend order [docs_link](https://docs.kucoin.com/#post-lend-order)
- [] cancel lend order [docs_link](https://docs.kucoin.com/#cancel-lend-order)
- [] set auto lend [docs_link](https://docs.kucoin.com/#set-auto-lend)
- [] get active order [docs_link](https://docs.kucoin.com/#get-active-order)
- [] get lent history [docs_link](https://docs.kucoin.com/#get-lent-history)
- [] get active lend order list [docs_link](https://docs.kucoin.com/#get-active-lend-order-list)
- [] get settled lend order history [docs_link](https://docs.kucoin.com/#get-settled-lend-order-history)
- [] get account lend record [docs_link](https://docs.kucoin.com/#get-account-lend-record)
- [] lending market data [docs_link](https://docs.kucoin.com/#lending-market-data)
- [] margin trade data [docs_link](https://docs.kucoin.com/#margin-trade-data)
#### Others
- [] server time [docs_link](https://docs.kucoin.com/#server-time)
- [] service status [docs_link](https://docs.kucoin.com/#service-status)
### WebSockets API
- [x] apply connect token [docs_link](https://docs.kucoin.com/#apply-connect-token)
- [x] create connection [docs_link](https://docs.kucoin.com/#create-connection)
- [x] ping [docs_link](https://docs.kucoin.com/#ping)
- [x] subscribe [docs_link](https://docs.kucoin.com/#subscribe)
- [x] unsubscribe [docs_link](https://docs.kucoin.com/#unsubscribe)
- [] multiplex [docs_link](https://docs.kucoin.com/#multiplex)

# Usage
## REST API
```julia
using UUIDs: uuid1
using Kucoin: ApiData, place_limit_order, get_all_tickers

println(get_all_tickers())

api_data = ApiData(;
        key="api-key",
        secret="api-secret",
        passphrase="api-passphrase",
    )
result = place_limit_order(
    api_data;
    price="100",
    size="0.452",
    time_in_force="FOK",
    client_order_id=string(uuid1()),
    side="sell",
    symbol="KCS-USDT",
)
println(result)
```

## WebSockets API
### Public channels
```julia
using Kucoin: WebSocketClient, subscribe, unsubscribe

ws_client = WebSocketClient()
subscribe(ws_client, "/market/ticker:BTC-USDT")
for _ in 1:5
    take!(ws_client)
end
unsubscribe(ws_client, "/market/ticker:BTC-USDT")
for _ in 1:5
    take!(ws_client)
end
```

### Private channels
```julia
using Kucoin: ApiData, WebSocketClient, subscribe, unsubscribe

api_data = ApiData(;
        key="api-key",
        secret="api-secret",
        passphrase="api-passphrase",
    )

ws_client = WebSocketClient(api_data)
subscribe(ws_client, "/account/balance")
for _ in 1:5
    take!(ws_client)
end
unsubscribe(ws_client, "/account/balance")
for _ in 1:5
    take!(ws_client)
end
```
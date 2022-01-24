# Welcome to Kucoin.jl
This is a Julia wrapper for the Kucoin exchange [API](https://docs.kucoin.com).

🚧 Work In Progress! 🚧

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
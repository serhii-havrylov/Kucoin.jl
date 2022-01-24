module Kucoin

using HTTP: Response, URI, request, iserror
using HTTP.WebSockets: WebSocket, WebSockets  # open
using SHA: hmac_sha256
using JSON3: JSON3  # Array, Object, read, write
using Base64: base64encode
using UUIDs: uuid1
import Base: string, take!, fetch, isready

# REST API
export ApiData
export get_symbols_list, get_all_tickers
export list_accounts, get_trade_fees
export place_limit_order, place_market_order, cancel_all_orders
export get_ws_token

# WebSocket API
export WebSocketClient
export subscribe, unsubscribe, take!, fetch, isready

"""
    Kucoin.ApiData(key, secret, passphrase)

Holds API data susch as API key, secret, passphrase, etc.

# Fields
- `key::String`: kucoin api key
- `secret::String`: kucoin api secret
- `passphrase::String`: kucoin api passphrase
- `encrypted_passphrase::String`: encrypted passpharase
"""
Base.@kwdef struct ApiData
    key::String
    secret::String
    passphrase::String
    encrypted_passphrase::String = _sign(secret, passphrase)
end

include("utils.jl")
include("market.jl")
include("user.jl")
include("trade.jl")
include("websockets.jl")

end

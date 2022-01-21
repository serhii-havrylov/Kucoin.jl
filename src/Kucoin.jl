module Kucoin

using HTTP: Response, URI, request, iserror
using SHA: hmac_sha256
using JSON3: JSON3, read, write
using Base64: base64encode
using UUIDs: uuid1
import Base: string

export ApiData
export get_symbols_list
export get_all_tickers
export list_accounts
export get_trade_fees
export place_limit_order
export place_market_order
export cancel_all_orders

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

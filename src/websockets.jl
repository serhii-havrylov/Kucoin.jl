"""
Kucoin.get_ws_token([api_data]) -> JSON3.Object

Apply for a websocket connection token. See Kucoin official 
[docs](https://docs.kucoin.com/#apply-connect-token) for more details.

# Arguments
- `api_data::UserApiData`: [Optional] holds API data susch as api key, secret, passphrase, 
etc. If absent returns a token that can be used only with public channels.

# Returns
- `JSON3.Object`
```json
{
  "instanceServers": [
    {
      "endpoint": "wss://push1-v2.kucoin.com/endpoint",
      "protocol": "websocket",
      "encrypt": true,
      "pingInterval": 50000,
      "pingTimeout": 10000
    }
  ],
  "token": "vYNlCtbz4XNJ1QncwWilJnBtmmfe4geLQDUA62kK=="
}
```
"""
function get_ws_token end

function get_ws_token(api_data::ApiData)::JSON3.Object
    return _handle(_kucoin_request(api_data, _HTTP_METHOD_POST, "/api/v1/bullet-private"))
end

function get_ws_token()::JSON3.Object
    return _handle(_kucoin_request(_HTTP_METHOD_POST, "/api/v1/bullet-public"))
end

struct WebSocketClient
    endpoint::String
    ping_interval::Integer
    is_private::Bool
    message_channel::Channel
    ws::Ref{WebSocket}
    write_lock::ReentrantLock
end

function WebSocketClient(api_data::ApiData, connection_id::String=string(uuid1()))
    return WebSocketClient(get_ws_token(api_data), connection_id, true)
end

function WebSocketClient(connection_id::String=string(uuid1()))
    return WebSocketClient(get_ws_token(), connection_id, false)
end

function WebSocketClient(ws_token::JSON3.Object, connection_id::String, is_private::Bool)
    endpoint = ws_token["instanceServers"][1]["endpoint"]
    token = ws_token["token"]
    ws_endpoint = "$endpoint?token=$token&connectId=$connection_id"
    ping_interval = ws_token["instanceServers"][1]["pingInterval"] ÷ 1000
    ws_client = WebSocketClient(
        ws_endpoint, ping_interval, is_private, Channel(), Ref{WebSocket}(), ReentrantLock()
    )
    ref_assigned_event = _start_read_loop(ws_client)
    wait(ref_assigned_event)
    return ws_client
end

take!(ws_client::WebSocketClient) = take!(ws_client.message_channel)
fetch(ws_client::WebSocketClient) = fetch(ws_client.message_channel)
isready(ws_client::WebSocketClient) = isready(ws_client.message_channel)

function subscribe(ws_client::WebSocketClient, topic::String)
    lock(ws_client.write_lock) do
        write(
            ws_client.ws[],
            """{"id": "$(uuid1())", "type": "subscribe", "topic": "$topic", "privateChannel": $(ws_client.is_private), "response": true}""",
        )
    end
end

function unsubscribe(ws_client::WebSocketClient, topic::String)
    lock(ws_client.write_lock) do
        write(
            ws_client.ws[],
            """{"id": "$(uuid1())", "type": "unsubscribe", "topic": "$topic", "privateChannel": $(ws_client.is_private), "response": true}""",
        )
    end
end

function _start_read_loop(ws_client::WebSocketClient)
    ref_assigned_event = Base.Event()
    task = @async WebSockets.open(ws_client.endpoint) do ws
        ws_client.ws[] = ws
        notify(ref_assigned_event)
        _start_ping_loop(ws_client)
        while !eof(ws)
            msg = JSON3.read(readavailable(ws))
            put!(ws_client.message_channel, msg)
        end
    end
    errormonitor(task)
    return ref_assigned_event
end

function _start_ping_loop(ws_client::WebSocketClient)
    task = @async while true
        lock(ws_client.write_lock) do
            write(ws_client.ws[], """{"id": "$(uuid1())", "type": "ping"}""")
        end
        sleep(ws_client.ping_interval)
    end
    return errormonitor(task)
end

-- 每个服务独立, 都需要引入skynet
local skynet = require "skynet"
require "skynet.manager"    -- 引入 skynet.register
local db = {}

local command = {}

function command.get(key)
    print("comman.get:"..key)   
    return db[key]
end

function command.set(key, value)
    print("comman.set:key="..key..",value:"..value) 
    db[key] = value
    local last = db[key]
    return last
end

skynet.start(function()
    print("==========Service2 Start=========")
    skynet.dispatch("lua", function(session, address, cmd, ...)
        print("==========Service2 dispatch============"..cmd)
        local f = command[cmd]      
        if f then
            -- 回应一个消息可以使用 skynet.ret(message, size) 。
            -- 它会将 message size 对应的消息附上当前消息的 session ，以及 skynet.PTYPE_RESPONSE 这个类别，发送给当前消息的来源 source 
            skynet.ret(skynet.pack(f(...))) --回应消息
        else
            error(string.format("Unknown command %s", tostring(cmd)))
        end
    end)
    --可以为自己注册一个别名。（别名必须在 32 个字符以内）
    skynet.register "SERVICE2"
end)

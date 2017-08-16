package.cpath = "/home/ec2-user/skynet/luaclib/?.so"
package.path = "/home/ec2-user/skynet/lualib/?.lua;/home/ec2-user/skynet/myexamples/e3/?.lua"

if _VERSION ~= "Lua 5.3" then
    error "Use lua 5.3"
end

local socket = require "client.socket"

local fd = assert(socket.connect("127.0.0.1", 8888))

-- 发送一条消息给服务器, 消息协议可自定义(官方推荐sproto协议,当然你也可以使用最熟悉的json)
socket.send(fd, "Hello world")

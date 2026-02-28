local function f(text, suffix)
    if string.sub(suffix, 1, 1) == "/" then
        return text .. string.sub(suffix, 2)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hello.txt', '/'), 'hello.txt')
end

os.exit(lu.LuaUnit.run())

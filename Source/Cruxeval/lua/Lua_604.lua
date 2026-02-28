local function f(text, start)
    return string.sub(text, 1, string.len(start)) == start
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Hello world', 'Hello'), true)
end

os.exit(lu.LuaUnit.run())

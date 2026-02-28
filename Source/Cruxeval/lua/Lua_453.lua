local function f(string, c)
    return string:sub(-#c) == c
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wrsch)xjmb8', 'c'), false)
end

os.exit(lu.LuaUnit.run())

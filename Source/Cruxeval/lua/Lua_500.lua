local function f(text, delim)
    return string.sub(text, 1, string.find(string.reverse(text), delim, 1, true) - 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dsj osq wi w', ' '), 'd')
end

os.exit(lu.LuaUnit.run())

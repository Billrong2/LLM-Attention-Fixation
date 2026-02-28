local function f(s, n)
    return string.lower(s) == string.lower(n)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('daaX', 'daaX'), true)
end

os.exit(lu.LuaUnit.run())

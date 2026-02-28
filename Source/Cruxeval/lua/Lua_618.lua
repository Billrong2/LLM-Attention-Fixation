local function f(match, fill, n)
    return string.sub(fill, 1, n) .. match
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('9', '8', 2), '89')
end

os.exit(lu.LuaUnit.run())

local function f(a, b, c, d)
    return a and b or c and d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('CJU', 'BFS', 'WBYDZPVES', 'Y'), 'BFS')
end

os.exit(lu.LuaUnit.run())

local function f(array, n)
    return {table.unpack(array, n+1)}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 0, 1, 2, 2, 2, 2}, 4), {2, 2, 2})
end

os.exit(lu.LuaUnit.run())

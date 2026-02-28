local function f(nums, n)
    return table.remove(nums, n+1)
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-7, 3, 1, -1, -1, 0, 4}, 6), 4)
end

os.exit(lu.LuaUnit.run())

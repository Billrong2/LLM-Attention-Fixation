local function f(nums, pop1, pop2)
    table.remove(nums, pop1)
    table.remove(nums, pop2)
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 5, 2, 3, 6}, 2, 4), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

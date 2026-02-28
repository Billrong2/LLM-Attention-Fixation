local function f(nums, idx, added)
    table.insert(nums, idx + 1, added)
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 2, 2, 3, 3}, 2, 3), {2, 2, 3, 2, 3, 3})
end

os.exit(lu.LuaUnit.run())

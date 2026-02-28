local function f(nums)
    local a = 1
    for i = 1, #nums do
        table.insert(nums, i, nums[a])
        a = a + 1
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 3, -1, 1, -2, 6}), {1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6})
end

os.exit(lu.LuaUnit.run())

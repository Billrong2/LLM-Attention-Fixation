local function f(nums)
    for i = 1, #nums do
        table.insert(nums, i, nums[i]^2)
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 4}), {1, 1, 1, 1, 2, 4})
end

os.exit(lu.LuaUnit.run())

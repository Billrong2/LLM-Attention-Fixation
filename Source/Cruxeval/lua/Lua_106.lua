local function f(nums)
    local count = #nums
    for i=1, count do
        table.insert(nums, i, nums[i]*2)
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 8, -2, 9, 3, 3}), {4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3})
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    local count = #nums
    for i=1, math.floor(count/2) do
        nums[i], nums[count-i+1] = nums[count-i+1], nums[i]
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 6, 1, 3, 1}), {1, 3, 1, 6, 2})
end

os.exit(lu.LuaUnit.run())

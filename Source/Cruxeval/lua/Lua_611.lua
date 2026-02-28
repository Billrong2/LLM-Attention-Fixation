local function f(nums)
    for i=1, math.floor(#nums/2) do
        nums[i], nums[#nums-i+1] = nums[#nums-i+1], nums[i]
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-6, -2, 1, -3, 0, 1}), {1, 0, -3, 1, -2, -6})
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    for i = #nums, 1, -3 do
        if nums[i] == 0 then
            nums = {}
            return false
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 0, 1, 2, 1}), false)
end

os.exit(lu.LuaUnit.run())

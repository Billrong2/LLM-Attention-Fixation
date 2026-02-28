local function f(nums)
    local count = 1
    for i=count, #nums-1, 2 do
        nums[i] = math.max(nums[i], nums[count])
        count = count + 1
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    local sum_ = 0
    local i = 1
    while i <= #nums do
        local num = nums[i]
        if num % 2 ~= 0 then
            table.remove(nums, i)
        else
            sum_ = sum_ + num
            i = i + 1
        end
    end
    return sum_
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({11, 21, 0, 11}), 0)
end

os.exit(lu.LuaUnit.run())

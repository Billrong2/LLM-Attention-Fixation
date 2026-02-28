local function f(nums, odd1, odd2)
    local i = 1
    while i <= #nums do
        if nums[i] == odd1 then
            table.remove(nums, i)
        elseif nums[i] == odd2 then
            table.remove(nums, i)
        else
            i = i + 1
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3}, 3, 1), {2, 7, 7, 6, 8, 4, 2, 5, 21})
end

os.exit(lu.LuaUnit.run())

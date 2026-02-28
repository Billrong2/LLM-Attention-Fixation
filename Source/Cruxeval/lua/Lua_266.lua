local function f(nums)
    for i = #nums, 1, -1 do
        if nums[i] % 2 == 1 then
            table.insert(nums, i+1, nums[i])
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 3, 4, 6, -2}), {2, 3, 3, 4, 6, -2})
end

os.exit(lu.LuaUnit.run())

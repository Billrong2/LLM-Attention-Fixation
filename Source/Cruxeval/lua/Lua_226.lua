local function f(nums)
    local n = #nums
    for i = 1, n do
        if nums[i] % 3 == 0 then
            table.insert(nums, nums[i])
            n = n + 1
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 3}), {1, 3, 3})
end

os.exit(lu.LuaUnit.run())

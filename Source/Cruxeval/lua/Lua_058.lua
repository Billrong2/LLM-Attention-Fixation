local function f(nums)
    local count = #nums
    for i = 0, count - 1 do
        local odd_even = i % 2
        table.insert(nums, nums[odd_even + 1])
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, 0, 0, 1, 1}), {-1, 0, 0, 1, 1, -1, 0, -1, 0, -1})
end

os.exit(lu.LuaUnit.run())

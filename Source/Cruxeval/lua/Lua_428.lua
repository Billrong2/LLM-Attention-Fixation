local function f(nums)
    for i=1, #nums do
        if i % 2 == 0 then
            table.insert(nums, nums[i] * nums[i+1])
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

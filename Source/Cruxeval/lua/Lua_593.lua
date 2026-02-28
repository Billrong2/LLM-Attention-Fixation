local function f(nums, n)
    local pos = #nums
    for i = -#nums, -1 do
        table.insert(nums, pos, nums[i])
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, 14), {})
end

os.exit(lu.LuaUnit.run())

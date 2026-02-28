local function f(nums, index)
    local result = nums[index + 1] % 42 + nums[index + 1] * 2
    table.remove(nums, index + 1)
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 2, 0, 3, 7}, 3), 9)
end

os.exit(lu.LuaUnit.run())

local function f(num1, num2, num3)
    local nums = {num1, num2, num3}
    table.sort(nums)
    return string.format("%d,%d,%d", nums[1], nums[2], nums[3])
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(6, 8, 8), '6,8,8')
end

os.exit(lu.LuaUnit.run())

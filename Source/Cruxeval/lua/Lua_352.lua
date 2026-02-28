local function f(nums)
    return nums[math.floor(#nums/2) + 1]
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, -3, -5, -7, 0}), -5)
end

os.exit(lu.LuaUnit.run())

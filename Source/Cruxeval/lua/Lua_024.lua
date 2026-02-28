local function f(nums, i)
    table.remove(nums, i + 1)
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({35, 45, 3, 61, 39, 27, 47}, 0), {45, 3, 61, 39, 27, 47})
end

os.exit(lu.LuaUnit.run())

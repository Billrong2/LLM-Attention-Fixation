local function f(nums, pos, value)
    table.insert(nums, pos + 1, value)
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 1, 2}, 2, 0), {3, 1, 0, 2})
end

os.exit(lu.LuaUnit.run())

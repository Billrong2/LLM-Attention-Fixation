local function f(nums, spot, idx)
    table.insert(nums, spot + 1, idx)
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 0, 1, 1}, 0, 9), {9, 1, 0, 1, 1})
end

os.exit(lu.LuaUnit.run())

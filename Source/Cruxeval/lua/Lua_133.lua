local function f(nums, elements)
    local result = {}
    for i=1, #elements do
        table.insert(result, table.remove(nums))
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({7, 1, 2, 6, 0, 2}, {9, 0, 3}), {7, 1, 2})
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    local count = #nums
    for i = #nums, 1, -1 do
        table.insert(nums, i, table.remove(nums, 1))
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, -5, -4}), {-4, -5, 0})
end

os.exit(lu.LuaUnit.run())

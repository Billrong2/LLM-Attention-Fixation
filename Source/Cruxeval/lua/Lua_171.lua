local function f(nums)
    local count = math.floor(#nums / 2)
    for i=1, count do
        table.remove(nums, 1)
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 4, 1, 2, 3}), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

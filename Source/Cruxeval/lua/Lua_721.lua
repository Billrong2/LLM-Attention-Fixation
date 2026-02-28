local function f(nums)
    local count = #nums
    for num = 2, count do
        table.sort(nums)
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-6, -5, -7, -8, 2}), {-8, -7, -6, -5, 2})
end

os.exit(lu.LuaUnit.run())

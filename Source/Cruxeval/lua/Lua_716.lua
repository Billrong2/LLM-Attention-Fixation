local function f(nums)
    local count = #nums
    while #nums > (count//2) do
        nums = {}
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 1, 2, 3, 1, 6, 3, 8}), {})
end

os.exit(lu.LuaUnit.run())

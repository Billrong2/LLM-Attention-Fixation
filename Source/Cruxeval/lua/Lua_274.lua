local function f(nums, target)
    local count = 0
    for _, n1 in ipairs(nums) do
        for _, n2 in ipairs(nums) do
            count = count + (n1 + n2 == target and 1 or 0)
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}, 4), 3)
end

os.exit(lu.LuaUnit.run())

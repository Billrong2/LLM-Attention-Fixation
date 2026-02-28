local function f(nums)
    local a = -1
    local b = {}
    for i = 2, #nums do
        b[#b + 1] = nums[i]
    end
    while a <= b[1] do
        table.remove(nums, 2)
        a = 0
        b = {}
        for i = 2, #nums do
            b[#b + 1] = nums[i]
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, 5, 3, -2, -6, 8, 8}), {-1, -2, -6, 8, 8})
end

os.exit(lu.LuaUnit.run())

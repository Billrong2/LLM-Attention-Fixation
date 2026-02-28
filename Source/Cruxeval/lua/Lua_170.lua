local function f(nums, number)
    local count = 0
    for i=1, #nums do
        if nums[i] == number then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({12, 0, 13, 4, 12}, 12), 2)
end

os.exit(lu.LuaUnit.run())

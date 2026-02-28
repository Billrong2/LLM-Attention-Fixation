local function f(nums, target)
    local cnt = 0
    for i=1,#nums do
        if nums[i] == target then
            cnt = cnt + 1
        end
    end
    return cnt * 2
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1}, 1), 4)
end

os.exit(lu.LuaUnit.run())

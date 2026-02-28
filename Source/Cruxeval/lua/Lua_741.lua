local function f(nums, p)
    local prev_p = p - 1
    if prev_p < 0 then prev_p = #nums - 1 end
    return nums[prev_p+1]
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 8, 2, 5, 3, 1, 9, 7}, 6), 1)
end

os.exit(lu.LuaUnit.run())

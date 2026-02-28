function f(nums, pos)
    local s = {1, #nums}
    if pos % 2 ~= 0 then
        s[2] = s[2] - 1
    end
    for i = 1, math.floor((s[2] - s[1] + 1) / 2) do
        nums[s[1] + i - 1], nums[s[2] - i + 1] = nums[s[2] - i + 1], nums[s[1] + i - 1]
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 1}, 3), {6, 1})
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    for i = 1, math.floor(#nums / 2) do
        nums[i], nums[#nums - i + 1] = nums[#nums - i + 1], nums[i]
    end
    return table.concat(nums)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, 9, 3, 1, -2}), '-2139-1')
end

os.exit(lu.LuaUnit.run())

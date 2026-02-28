local function f(nums, fill)
    local ans = {}
    for i, v in ipairs(nums) do
        ans[v] = fill
    end
    return ans
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 1, 1, 2}, 'abcca'), {[0] = 'abcca', [1] = 'abcca', [2] = 'abcca'})
end

os.exit(lu.LuaUnit.run())

local function f(nums, delete)
    for i, v in ipairs(nums) do
        if v == delete then
            table.remove(nums, i)
            break
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({4, 5, 3, 6, 1}, 5), {4, 3, 6, 1})
end

os.exit(lu.LuaUnit.run())

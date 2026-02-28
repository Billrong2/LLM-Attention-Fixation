local function f(nums, val)
    local new_list = {}
    for _, i in ipairs(nums) do
        for j = 1, val do
            table.insert(new_list, i)
        end
    end
    local sum = 0
    for _, v in ipairs(new_list) do
        sum = sum + v
    end
    return sum
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({10, 4}, 3), 42)
end

os.exit(lu.LuaUnit.run())

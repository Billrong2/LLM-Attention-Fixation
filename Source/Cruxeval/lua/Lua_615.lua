local function f(in_list, num)
    table.insert(in_list, num)
    local max_value = -math.huge
    local max_index = -1
    for i = 1, #in_list - 1 do
        if in_list[i] > max_value then
            max_value = in_list[i]
            max_index = i
        end
    end
    return max_index - 1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, 12, -6, -2}, -1), 1)
end

os.exit(lu.LuaUnit.run())

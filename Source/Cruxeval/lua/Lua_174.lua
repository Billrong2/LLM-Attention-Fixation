local function f(lst)
    local temp = {}
    for i = 4, 2, -1 do
        table.insert(temp, lst[i])
    end
    for i = 2, 4 do
        lst[i] = temp[i - 1]
    end
    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}), {1, 3, 2})
end

os.exit(lu.LuaUnit.run())

local function f(lst)
    local function operation(x)
        local i, j = 1, #x
        while i < j do
            x[i], x[j] = x[j], x[i]
            i = i + 1
            j = j - 1
        end
        return x
    end
    new_list = {}
    for i = 1, #lst do
        new_list[i] = lst[i]
    end
    table.sort(new_list)
    operation(new_list)
    return lst
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 4, 2, 8, 15}), {6, 4, 2, 8, 15})
end

os.exit(lu.LuaUnit.run())

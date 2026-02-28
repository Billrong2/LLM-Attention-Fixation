local function f(lst, mode)
    local result = {}
    for i = 1, #lst do
        result[i] = lst[i]
    end
    if mode == 1 then
        table.sort(result, function(a, b) return lst[a] > lst[b] end)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4}, 1), {4, 3, 2, 1})
end

os.exit(lu.LuaUnit.run())

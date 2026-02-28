local function f(dct)
    local lst = {}
    for key, value in pairs(dct) do
        table.insert(lst, {key, value})
    end
    table.sort(lst, function(a, b) return a[1] < b[1] end)
    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['a'] = 1, ['b'] = 2, ['c'] = 3}), {{'a', 1}, {'b', 2}, {'c', 3}})
end

os.exit(lu.LuaUnit.run())

local function f(dic)
    local sorted_items = {}
    for key, value in pairs(dic) do
        table.insert(sorted_items, {key, value})
    end
    table.sort(sorted_items, function(a, b) return a[1] < b[1] end)
    return sorted_items
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['b'] = 1, ['a'] = 2}), {{'a', 2}, {'b', 1}})
end

os.exit(lu.LuaUnit.run())

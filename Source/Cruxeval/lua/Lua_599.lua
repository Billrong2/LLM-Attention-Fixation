function f(a, b)
    local a_str = table.concat(a, b)
    local lst = {}
    for i = 1, #a_str, 2 do
        table.insert(lst, string.sub(a_str, i, i + i - 1))
        table.insert(lst, string.sub(a_str, i + i, #a_str))
    end
    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'a', 'b', 'c'}, ' '), {'a', ' b c', 'b c', '', 'c', ''})
end

os.exit(lu.LuaUnit.run())

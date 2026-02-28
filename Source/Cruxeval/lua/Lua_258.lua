local function f(L, m, start, step)
    table.insert(L, start + 1, m)
    for x=start-1, 2, -step do
        start = start - 1
        local index = start + 1
        local val = table.remove(L, index)
        table.insert(L, start + 1, val)
    end
    return L
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 7, 9}, 3, 3, 2), {1, 2, 7, 3, 9})
end

os.exit(lu.LuaUnit.run())

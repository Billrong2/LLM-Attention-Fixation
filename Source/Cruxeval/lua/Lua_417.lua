local function f(lst)
    table.remove(lst, 1)
    return lst
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({7, 8, 2, 8}), {8, 2, 8})
end

os.exit(lu.LuaUnit.run())

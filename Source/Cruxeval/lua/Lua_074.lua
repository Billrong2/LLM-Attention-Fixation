local function f(lst, i, n)
    table.insert(lst, i + 1, n)
    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({44, 34, 23, 82, 24, 11, 63, 99}, 4, 15), {44, 34, 23, 82, 15, 24, 11, 63, 99})
end

os.exit(lu.LuaUnit.run())

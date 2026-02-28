local function f(array, i_num, elem)
    table.insert(array, i_num + 1, elem)
    return array
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-4, 1, 0}, 1, 4), {-4, 4, 1, 0})
end

os.exit(lu.LuaUnit.run())

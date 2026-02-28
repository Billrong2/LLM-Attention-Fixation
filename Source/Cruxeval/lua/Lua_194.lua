local function f(matr, insert_loc)
    insert_loc = insert_loc + 1
    table.insert(matr, insert_loc, {})
    return matr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{5, 6, 2, 3}, {1, 9, 5, 6}}, 0), {{}, {5, 6, 2, 3}, {1, 9, 5, 6}})
end

os.exit(lu.LuaUnit.run())

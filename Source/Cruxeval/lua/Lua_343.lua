local function f(array, elem)
    for i=1,#elem do
        table.insert(array, elem[i])
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{1, 2, 3}, {1, 2}, 1}, {{1, 2, 3}, 3, {2, 1}}), {{1, 2, 3}, {1, 2}, 1, {1, 2, 3}, 3, {2, 1}})
end

os.exit(lu.LuaUnit.run())

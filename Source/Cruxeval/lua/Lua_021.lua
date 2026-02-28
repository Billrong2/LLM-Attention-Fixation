local function f(array)
    local n = table.remove(array)
    table.insert(array, n)
    table.insert(array, n)
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1, 2, 2}), {1, 1, 2, 2, 2})
end

os.exit(lu.LuaUnit.run())

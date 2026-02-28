local function f(values)
    table.sort(values)
    return values
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1, 1, 1}), {1, 1, 1, 1})
end

os.exit(lu.LuaUnit.run())

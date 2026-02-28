local function f(orig)
    local copy = orig
    table.insert(copy, 100)
    table.remove(orig)
    return copy
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

local function f(code)
    return string.format("%s: %s", code, "b'" .. code .. "'")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('148'), "148: b'148'")
end

os.exit(lu.LuaUnit.run())

local function f(text)
    return text:upper() == tostring(text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('VTBAEPJSLGAHINS'), true)
end

os.exit(lu.LuaUnit.run())

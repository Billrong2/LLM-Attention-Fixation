local function f(text, char)
    return char:lower() == char and text:lower() == text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abc', 'e'), true)
end

os.exit(lu.LuaUnit.run())

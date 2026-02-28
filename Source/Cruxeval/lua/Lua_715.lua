local function f(text, char)
    return string.len(text:gsub(char, "")) % 2 ~= 0
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abababac', 'a'), false)
end

os.exit(lu.LuaUnit.run())

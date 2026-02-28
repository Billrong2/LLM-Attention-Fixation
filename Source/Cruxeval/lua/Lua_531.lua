local function f(text, x)
    if string.sub(text, 1, #x) ~= x then
        return f(string.sub(text, 2), x)
    else
        return text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Ibaskdjgblw asdl ', 'djgblw'), 'djgblw asdl ')
end

os.exit(lu.LuaUnit.run())

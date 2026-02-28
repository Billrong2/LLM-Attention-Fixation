local function f(text, count)
    for i=1, count do
        text = string.reverse(text)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('439m2670hlsw', 3), 'wslh0762m934')
end

os.exit(lu.LuaUnit.run())

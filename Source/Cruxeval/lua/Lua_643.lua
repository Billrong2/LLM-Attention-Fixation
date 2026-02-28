local function f(text, suffix)
    if text:sub(-#suffix) == suffix then
        text = text:sub(1, -#suffix - 1) .. string.upper(text:sub(-1, -1))
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('damdrodm', 'm'), 'damdrodM')
end

os.exit(lu.LuaUnit.run())

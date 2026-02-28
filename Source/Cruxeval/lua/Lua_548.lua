local function f(text, suffix)
    if suffix and text and text:sub(-#suffix) == suffix then
        return text:sub(1, -#suffix - 1)
    else
        return text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('spider', 'ed'), 'spider')
end

os.exit(lu.LuaUnit.run())

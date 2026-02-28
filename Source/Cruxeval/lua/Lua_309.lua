local function f(text, suffix)
    text = text .. suffix
    while text:sub(-#suffix) == suffix do
        text = text:sub(1, -2)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('faqo osax f', 'f'), 'faqo osax ')
end

os.exit(lu.LuaUnit.run())

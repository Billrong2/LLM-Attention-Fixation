local function f(text, suffix)
    if text:sub(-suffix:len()) == suffix then
        return text:sub(1, -suffix:len() - 1)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('zejrohaj', 'owc'), 'zejrohaj')
end

os.exit(lu.LuaUnit.run())

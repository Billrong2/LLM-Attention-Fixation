local function f(text)
    if text:upper() == text then
        return 'ALL UPPERCASE'
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Hello Is It MyClass'), 'Hello Is It MyClass')
end

os.exit(lu.LuaUnit.run())

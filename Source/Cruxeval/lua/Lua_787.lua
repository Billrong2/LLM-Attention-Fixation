local function f(text)
    if string.len(text) == 0 then
        return ''
    end
    text = string.lower(text)
    return string.upper(string.sub(text, 1, 1)) .. string.sub(text, 2)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('xzd'), 'Xzd')
end

os.exit(lu.LuaUnit.run())

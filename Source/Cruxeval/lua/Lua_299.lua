local function f(text, char)
    if string.sub(text, -string.len(char)) ~= char then
        return f(char .. text, char)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('staovk', 'k'), 'staovk')
end

os.exit(lu.LuaUnit.run())

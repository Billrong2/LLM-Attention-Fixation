local function f(text, pref)
    local length = string.len(pref)
    if string.sub(text, 1, length) == pref then
        return string.sub(text, length+1)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('kumwwfv', 'k'), 'umwwfv')
end

os.exit(lu.LuaUnit.run())

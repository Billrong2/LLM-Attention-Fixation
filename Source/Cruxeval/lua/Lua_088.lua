local function f(s1, s2)
    if string.sub(s2, -string.len(s1)) == s1 then
        s2 = string.sub(s2, 1, -string.len(s1) - 1)
    end
    return s2
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('he', 'hello'), 'hello')
end

os.exit(lu.LuaUnit.run())

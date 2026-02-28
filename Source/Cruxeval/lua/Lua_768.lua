local function f(s, o)
    if string.sub(s, 1, string.len(o)) == o then
        return s
    end
    return o .. f(s, string.sub(o, string.len(o) - 1, 1, -1))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abba', 'bab'), 'bababba')
end

os.exit(lu.LuaUnit.run())

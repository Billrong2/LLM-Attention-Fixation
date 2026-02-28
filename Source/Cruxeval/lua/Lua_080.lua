local function f(s)
    return string.reverse(string.match(s, "^%s*(.-)%s*$"))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ab        '), 'ba')
end

os.exit(lu.LuaUnit.run())

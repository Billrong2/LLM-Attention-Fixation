local function f(s, amount)
    return string.rep('z', amount - #s) .. s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abc', 8), 'zzzzzabc')
end

os.exit(lu.LuaUnit.run())

local function f(s)
    return string.gsub(s, ".", string.lower)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abcDEFGhIJ'), 'abcdefghij')
end

os.exit(lu.LuaUnit.run())

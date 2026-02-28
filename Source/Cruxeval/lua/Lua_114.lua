local function f(text, sep)
    return {string.match(text, "(.-)" .. sep .. "(.-)" .. sep .. "(.*)")}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a-.-.b', '-.'), {'a', '', 'b'})
end

os.exit(lu.LuaUnit.run())

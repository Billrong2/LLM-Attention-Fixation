local function f(s, tab)
    return string.gsub(s, "\t", string.rep(" ", tab))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Join us in Hungary', 4), 'Join us in Hungary')
end

os.exit(lu.LuaUnit.run())

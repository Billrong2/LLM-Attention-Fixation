local function f(text, char, replace)
    return string.gsub(text, char, replace)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a1a8', '1', 'n2'), 'an2a8')
end

os.exit(lu.LuaUnit.run())

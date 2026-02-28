local function f(s, sep)
    s = s .. sep
    return string.match(s, "(.-)" .. sep .. "$")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('234dsfssdfs333324314', 's'), '234dsfssdfs333324314')
end

os.exit(lu.LuaUnit.run())

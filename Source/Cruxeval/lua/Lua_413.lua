local function f(s)
    return string.sub(s, 4) .. string.sub(s, 3, 3) .. string.sub(s, 6, 8)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jbucwc'), 'cwcuc')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    return text:sub(-1) .. text:sub(1, -2)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hellomyfriendear'), 'rhellomyfriendea')
end

os.exit(lu.LuaUnit.run())

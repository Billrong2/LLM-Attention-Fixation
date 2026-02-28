local function f(number)
    return tonumber(number) ~= nil
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dummy33;d'), false)
end

os.exit(lu.LuaUnit.run())

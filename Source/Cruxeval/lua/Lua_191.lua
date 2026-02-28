local function f(string)
    if string:upper() == string then
        return true
    else
        return false
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Ohno'), false)
end

os.exit(lu.LuaUnit.run())

local function f(text)
    return not tonumber(text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('the speed is -36 miles per hour'), true)
end

os.exit(lu.LuaUnit.run())

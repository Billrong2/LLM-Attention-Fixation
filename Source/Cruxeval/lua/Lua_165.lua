local function f(text, lower, upper)
    return string.sub(text, lower+1, upper):match("^[%w%p%s]+$") ~= nil
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('=xtanp|sugv?z', 3, 6), true)
end

os.exit(lu.LuaUnit.run())

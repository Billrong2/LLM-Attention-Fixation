local function f(s)
    return #s == string.len(string.gsub(s, '0', '')) + string.len(string.gsub(s, '1', ''))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('102'), false)
end

os.exit(lu.LuaUnit.run())

local function f(s)
    return string.gsub(s, "%(", "["):gsub("%)", "]")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('(ac)'), '[ac]')
end

os.exit(lu.LuaUnit.run())

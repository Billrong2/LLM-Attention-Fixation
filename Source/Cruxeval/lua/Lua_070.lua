local function f(x)
    local a = 0
    for i in string.gmatch(x, "%S+") do
        a = a + string.len(string.format("%0"..(string.len(i)*2).."d", tonumber(i)))
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('999893767522480'), 30)
end

os.exit(lu.LuaUnit.run())

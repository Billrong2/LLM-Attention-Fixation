local function f(s, from_c, to_c)
    local table = s:gsub(from_c, to_c)
    return table
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('aphid', 'i', '?'), 'aph?d')
end

os.exit(lu.LuaUnit.run())

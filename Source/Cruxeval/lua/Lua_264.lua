local function f(test_str)
    local s = test_str:gsub('a', 'A')
    return s:gsub('e', 'A')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('papera'), 'pApArA')
end

os.exit(lu.LuaUnit.run())

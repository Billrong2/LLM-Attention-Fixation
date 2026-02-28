local function f(s)
    return string.gsub(string.gsub(s, 'a', ''), 'r', '')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('rpaar'), 'p')
end

os.exit(lu.LuaUnit.run())

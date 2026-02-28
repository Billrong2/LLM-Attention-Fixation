local function f(text, prefix)
    return string.sub(text, string.len(prefix) + 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('123x John z', 'z'), '23x John z')
end

os.exit(lu.LuaUnit.run())

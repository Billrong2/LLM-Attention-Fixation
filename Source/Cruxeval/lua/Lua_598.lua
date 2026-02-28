local function f(text, n)
    local length = string.len(text)
    return string.sub(text, length*(n%4)+1, length)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abc', 1), '')
end

os.exit(lu.LuaUnit.run())

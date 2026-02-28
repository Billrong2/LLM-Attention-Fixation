local function f(text)
    local string_a, string_b = text:match("([^,]+),([^,]+)")
    return -(#string_a + #string_b)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dog,cat'), -6)
end

os.exit(lu.LuaUnit.run())

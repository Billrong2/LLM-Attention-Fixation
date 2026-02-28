local function f(s, char)
    local count = string.gsub(s, char, "")
    local base = char .. string.rep(char, #count)
    return string.gsub(s, base, "")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mnmnj krupa...##!@#!@#$$@##', '@'), 'mnmnj krupa...##!@#!@#$$@##')
end

os.exit(lu.LuaUnit.run())

local function strip(s, chars)
    return (string.gsub(s, '^[' .. chars .. ']*', ''))
end

local function f(text, strip_chars)
    local reversed = text:reverse()
    local stripped = strip(reversed, strip_chars)
    return stripped:reverse()
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('tcmfsmj', 'cfj'), 'tcmfsm')
end

os.exit(lu.LuaUnit.run())

local function f(text, delim)
    local first, second = string.match(text, '(.-)%'..delim..'(.*)')
    return second .. delim .. first
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bpxa24fc5.', '.'), '.bpxa24fc5')
end

os.exit(lu.LuaUnit.run())

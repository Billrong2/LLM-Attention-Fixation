local function f(text)
    local lines = {}
    for line in text:gmatch("[^\n]*\n?") do
        table.insert(lines, line)
    end
    return #lines
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ncdsdfdaaa0a1cdscsk*XFd'), 1)
end

os.exit(lu.LuaUnit.run())

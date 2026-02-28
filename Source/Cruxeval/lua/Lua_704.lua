local function f(s, n, c)
    local width = string.len(c) * n
    while string.len(s) < width do
        s = c .. s
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('.', 0, '99'), '.')
end

os.exit(lu.LuaUnit.run())

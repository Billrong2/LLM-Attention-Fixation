local function f(n)
    local b = {}
    local str_n = tostring(n)
    for i=1, #str_n do
        table.insert(b, string.sub(str_n, i, i))
    end
    for i=3, #b do
        b[i] = b[i] .. '+'
    end
    return b
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(44), {'4', '4'})
end

os.exit(lu.LuaUnit.run())

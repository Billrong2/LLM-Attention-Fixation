local function f(s)
    local l = {}
    for i = 1, string.len(s) do
        l[i] = string.lower(string.sub(s, i, i))
        if not string.match(l[i], "%d") then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(''), true)
end

os.exit(lu.LuaUnit.run())

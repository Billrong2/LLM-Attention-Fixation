local function f(a)
    if #a >= 2 and a[1] > 0 and a[2] > 0 then
        table.sort(a, function(x, y) return x > y end)
        return a
    end
    table.insert(a, 0)
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {0})
end

os.exit(lu.LuaUnit.run())

local function f(n, m)
    local arr = {}
    for i = 1, n do
        table.insert(arr, i)
    end
    for i = 1, m do
        table.remove(arr)
    end
    return arr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1, 3), {})
end

os.exit(lu.LuaUnit.run())

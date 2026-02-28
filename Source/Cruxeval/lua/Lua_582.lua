local function f(k, j)
    local arr = {}
    for i=1, k do
        table.insert(arr, j)
    end
    return arr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(7, 5), {5, 5, 5, 5, 5, 5, 5})
end

os.exit(lu.LuaUnit.run())

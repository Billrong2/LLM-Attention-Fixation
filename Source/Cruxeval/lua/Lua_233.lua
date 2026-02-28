local function f(xs)
    local n = #xs
    for i = n, 1, -1 do
        table.insert(xs, 1, table.remove(xs, n))
    end
    return xs
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

local function f(xs)
    local new_x = xs[1] - 1
    table.remove(xs, 1)
    while new_x <= xs[1] do
        table.remove(xs, 1)
        new_x = new_x - 1
    end
    table.insert(xs, 1, new_x)
    return xs
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 3, 4, 1, 2, 3, 5}), {5, 3, 4, 1, 2, 3, 5})
end

os.exit(lu.LuaUnit.run())

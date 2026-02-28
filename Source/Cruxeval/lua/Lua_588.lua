local function f(items, target)
    for i = 1, #items do
        if items[i] == target then
            return i - 1
        end
    end
    return -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'1', '+', '-', '**', '//', '*', '+'}, '**'), 3)
end

os.exit(lu.LuaUnit.run())

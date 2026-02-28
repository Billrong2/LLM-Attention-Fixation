local function f(numbers, elem, idx)
    if idx > #numbers then
        table.insert(numbers, elem)
    else
        table.insert(numbers, idx, elem)
    end
    return numbers
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}, 8, 5), {1, 2, 3, 8})
end

os.exit(lu.LuaUnit.run())

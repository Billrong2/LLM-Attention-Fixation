local function f(numbers, index)
    local new_numbers = {}
    for i = index, #numbers do
        table.insert(new_numbers, numbers[i])
    end
    for i = index, 1, -1 do
        table.insert(new_numbers, 1, numbers[i])
    end
    return new_numbers
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-2, 4, -4}, 0), {-2, 4, -4})
end

os.exit(lu.LuaUnit.run())

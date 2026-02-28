local function f(numbers)
    local new_numbers = {}
    for i = 1, #numbers do
        table.insert(new_numbers, numbers[#numbers - i + 1])
    end
    return new_numbers
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({11, 3}), {3, 11})
end

os.exit(lu.LuaUnit.run())

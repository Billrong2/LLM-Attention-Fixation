local function f(numbers, num, val)
    while #numbers < num do
        table.insert(numbers, math.floor(#numbers / 2) + 1, val)
    end
    for i=1, math.floor(#numbers / (num - 1)) - 4 do
        table.insert(numbers, math.floor(#numbers / 2) + 1, val)
    end
    return table.concat(numbers, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, 0, 1), '')
end

os.exit(lu.LuaUnit.run())

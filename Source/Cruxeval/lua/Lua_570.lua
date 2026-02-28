local function f(array, index, value)
    table.insert(array, 1, index + 1)
    if value >= 1 then
        table.insert(array, index + 1, value)
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2}, 0, 2), {2, 1, 2})
end

os.exit(lu.LuaUnit.run())

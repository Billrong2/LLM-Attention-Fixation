local function f(array)
    local result = {}
    for i=#array, 1, -1 do
        table.insert(result, array[i] * 2)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4, 5}), {10, 8, 6, 4, 2})
end

os.exit(lu.LuaUnit.run())

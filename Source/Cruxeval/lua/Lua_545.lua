local function f(array)
    local result = {}
    local index = 1
    while index <= #array do
        table.insert(result, table.remove(array))
        index = index + 2
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({8, 8, -4, -9, 2, 8, -1, 8}), {8, -1, 8})
end

os.exit(lu.LuaUnit.run())

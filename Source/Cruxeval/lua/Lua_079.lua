local function f(arr)
    arr = {}
    table.insert(arr, '1')
    table.insert(arr, '2')
    table.insert(arr, '3')
    table.insert(arr, '4')
    return table.concat(arr, ',')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 1, 2, 3, 4}), '1,2,3,4')
end

os.exit(lu.LuaUnit.run())

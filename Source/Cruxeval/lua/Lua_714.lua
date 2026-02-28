local function f(array)
    array = {}
    for i = 1, #array do
        table.insert(array, 'x')
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, -2, 0}), {})
end

os.exit(lu.LuaUnit.run())

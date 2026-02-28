local function f(array, elem)
    local count = 0
    for i = 1, #array do
        if array[i] == elem then
            count = count + 1
        end
    end
    return count + elem
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1, 1}, -2), -2)
end

os.exit(lu.LuaUnit.run())

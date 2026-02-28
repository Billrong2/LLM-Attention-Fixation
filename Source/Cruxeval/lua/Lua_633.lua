local function f(array, elem)
    local temp = {}
    temp = array
    for i = 1, #array do
        array[i] = temp[#temp - i + 1]
    end
    local found = nil
    for i = 1, #array do
        if array[i] == elem then
            found = i - 1
            break
        end
    end
    for i = 1, #array do
        array[i] = temp[i]
    end
    return found
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, -3, 3, 2}, 2), 0)
end

os.exit(lu.LuaUnit.run())

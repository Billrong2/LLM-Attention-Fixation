local function f(array, elem)
    local k = 1
    local l = {}
    for i=1, #array do
        l[i] = array[i]
        if array[i] > elem then
            table.insert(array, k, elem)
            break
        end
        k = k + 1
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 4, 3, 2, 1, 0}, 3), {3, 5, 4, 3, 2, 1, 0})
end

os.exit(lu.LuaUnit.run())

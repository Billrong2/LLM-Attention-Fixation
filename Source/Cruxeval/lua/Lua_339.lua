local function f(array, elem)
    elem = tostring(elem)
    local d = 0
    for i = 1, #array do
        if tostring(array[i]) == elem then
            d = d + 1
        end
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, 2, 1, -8, -8, 2}, 2), 2)
end

os.exit(lu.LuaUnit.run())

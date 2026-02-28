local function f(array, elem)
    local ind = -1
    for i, v in ipairs(array) do
        if v == elem then
           ind = i - 1
           break
        end
    end
    return ind * 2 + array[#array - ind] * 3
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-1, 2, 1, -8, 2}, 2), -22)
end

os.exit(lu.LuaUnit.run())

local function f(array, x, i)
    if i < -#array or i > #array - 1 then
        return 'no'
    end
    local temp = array[i+1]
    array[i+1] = x
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, 11, 4), {1, 2, 3, 4, 11, 6, 7, 8, 9, 10})
end

os.exit(lu.LuaUnit.run())

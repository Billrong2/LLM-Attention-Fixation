local function f(array)
    local zero_len = (#array - 1) % 3
    for i = 1, zero_len do
        array[i] = '0'
    end
    for i = zero_len + 2, #array, 3 do
        array[i - 1] = '0'
        array[i] = '0'
        array[i + 1] = '0'
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({9, 2}), {'0', 2})
end

os.exit(lu.LuaUnit.run())

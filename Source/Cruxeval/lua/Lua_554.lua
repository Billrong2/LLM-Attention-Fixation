local function f(arr)
    local reversed_arr = {}
    for i = #arr, 1, -1 do
        table.insert(reversed_arr, arr[i])
    end
    return reversed_arr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 0, 1, 9999, 3, -5}), {-5, 3, 9999, 1, 0, 2})
end

os.exit(lu.LuaUnit.run())

local function f(arr1, arr2)
    local new_arr = {}
    for i=1, #arr1 do
        table.insert(new_arr, arr1[i])
    end
    for i=1, #arr2 do
        table.insert(new_arr, arr2[i])
    end
    return new_arr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 1, 3, 7, 8}, {'', 0, -1, {}}), {5, 1, 3, 7, 8, '', 0, -1, {}})
end

os.exit(lu.LuaUnit.run())

local function f(array)
    local array_2 = {}
    for i=1, #array do
        if array[i] > 0 then
            table.insert(array_2, array[i])
        end
    end
    table.sort(array_2, function(a, b) return a > b end)
    return array_2
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({4, 8, 17, 89, 43, 14}), {89, 43, 17, 14, 8, 4})
end

os.exit(lu.LuaUnit.run())

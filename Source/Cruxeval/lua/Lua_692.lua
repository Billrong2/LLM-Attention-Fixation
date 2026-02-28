local function f(array)
    local a = {}
    table.sort(array, function(x, y) return x > y end)
    for i = 1, #array do
        if array[i] ~= 0 then
            table.insert(a, array[i])
        end
    end
    table.sort(a, function(x, y) return x < y end)
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

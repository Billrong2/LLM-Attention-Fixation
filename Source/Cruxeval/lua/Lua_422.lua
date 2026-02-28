local function f(array)
    local new_array = {}
    for i=#array, 1, -1 do
        table.insert(new_array, array[i])
    end
    
    local result = {}
    for _, x in ipairs(new_array) do
        table.insert(result, x*x)
    end
    
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 1}), {1, 4, 1})
end

os.exit(lu.LuaUnit.run())

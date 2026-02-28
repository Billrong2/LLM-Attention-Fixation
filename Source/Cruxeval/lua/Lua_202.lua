local function f(array, lst)
    for _, v in ipairs(lst) do
        table.insert(array, v)
    end
    
    local temp = {}
    for _, e in ipairs(array) do
        if e % 2 == 0 then
            table.insert(temp, e)
        end
    end
    
    local result = {}
    for _, e in ipairs(array) do
        if e >= 10 then
            table.insert(result, e)
        end
    end
    
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 15}, {15, 1}), {15, 15})
end

os.exit(lu.LuaUnit.run())

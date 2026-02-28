local function f(n, array)
    local final = {array} 
    for i = 1, n do
        local arr = {}
        for _, v in ipairs(array) do
            table.insert(arr, v)
        end
        for _, v in ipairs(final[#final]) do
            table.insert(arr, v)
        end
        table.insert(final, arr)
    end
    return final
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1, {1, 2, 3}), {{1, 2, 3}, {1, 2, 3, 1, 2, 3}})
end

os.exit(lu.LuaUnit.run())

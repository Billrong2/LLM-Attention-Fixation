local function f(array, num)
    local reverse = false
    if num < 0 then
        reverse = true
        num = num * -1
    end
    local temp = {}
    for i = #array, 1, -1 do
        table.insert(temp, array[i])
    end

    local result = {}
    for i = 1, num do
        for j = 1, #temp do
            table.insert(result, temp[j])
        end
    end

    if reverse then
        local reversedArray = {}
        for i = #result, 1, -1 do
            table.insert(reversedArray, result[i])
        end
        return reversedArray
    end

    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2}, 1), {2, 1})
end

os.exit(lu.LuaUnit.run())

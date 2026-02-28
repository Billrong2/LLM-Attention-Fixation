local function f(array, target)
    local count, i = 0, 1
    for j = 2, #array do
        if array[j] > array[j-1] and array[j] <= target then
            count = count + i
        elseif array[j] <= array[j-1] then
            i = 1
        else
            i = i + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, -1, 4}, 2), 1)
end

os.exit(lu.LuaUnit.run())

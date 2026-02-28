local function f(array)
    local newArray = {table.unpack(array)}
    local prev = array[1]
    for i = 2, #array do
        if prev ~= array[i] then
            newArray[i] = array[i]
        else
            table.remove(newArray, i)
        end
        prev = array[i]
    end
    return newArray
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

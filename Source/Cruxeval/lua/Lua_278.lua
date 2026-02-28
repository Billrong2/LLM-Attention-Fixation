local function f(array1, array2)
    local result = {}
    for _, key in ipairs(array1) do
        result[key] = {}
        for _, el in ipairs(array2) do
            if key * 2 > el then
                table.insert(result[key], el)
            end
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 132}, {5, 991, 32, 997}), {[0] = {}, [132] = {5, 32}})
end

os.exit(lu.LuaUnit.run())

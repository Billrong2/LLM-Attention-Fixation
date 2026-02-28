local function f(array, elem)
    for idx, e in ipairs(array) do
        if e > elem and array[idx - 1] < elem then
            table.insert(array, idx, elem)
        end
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 5, 8}, 6), {1, 2, 3, 5, 6, 8})
end

os.exit(lu.LuaUnit.run())

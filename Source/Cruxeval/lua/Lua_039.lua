local function f(array, elem)
    for i, value in ipairs(array) do
        if value == elem then
            return i - 1
        end
    end
    return -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 2, 7, 1}, 6), 0)
end

os.exit(lu.LuaUnit.run())

local function f(array, index)
    if index < 0 then
        index = #array + index
    end
    return array[index + 1]
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1}, 0), 1)
end

os.exit(lu.LuaUnit.run())

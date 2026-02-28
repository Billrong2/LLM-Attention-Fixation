local function f(array)
    local i = 1
    while i <= #array do
        if array[i] < 0 then
            table.remove(array, i)
        else
            i = i + 1
        end
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

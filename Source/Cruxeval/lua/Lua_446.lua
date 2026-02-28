local function f(array)
    local l = #array
    if l % 2 == 0 then
        array = {}
    else
        for i=1, math.floor(l / 2) do
            array[i], array[l-i+1] = array[l-i+1], array[i]
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

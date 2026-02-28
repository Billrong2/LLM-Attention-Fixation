local function f(array)
    local d = {}
    for i = 1, #array do
        local key = array[i][1]
        local value = array[i][2]
        d[key] = value
        if value < 0 or value > 9 then
            return nil
        end
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{8, 5}, {8, 2}, {5, 3}}), {[8] = 2, [5] = 3})
end

os.exit(lu.LuaUnit.run())

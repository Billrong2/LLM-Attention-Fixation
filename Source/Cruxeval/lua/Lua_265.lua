local function f(d, k)
    local new_d = {}
    for key, val in pairs(d) do
        if key < k then
            new_d[key] = val
        end
    end
    return new_d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = 2, [2] = 4, [3] = 3}, 3), {[1] = 2, [2] = 4})
end

os.exit(lu.LuaUnit.run())

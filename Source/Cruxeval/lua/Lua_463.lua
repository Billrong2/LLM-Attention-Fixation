local function f(dict)
    local result = {}
    for k, v in pairs(dict) do
        if not dict[v] then
            result[k] = v
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[-1] = -1, [5] = 5, [3] = 6, [-4] = -4}), {[3] = 6})
end

os.exit(lu.LuaUnit.run())

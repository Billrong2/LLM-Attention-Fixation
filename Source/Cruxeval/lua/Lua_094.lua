local function f(a, b)
    local result = {}
    for k, v in pairs(a) do
        result[k] = v
    end
    for k, v in pairs(b) do
        result[k] = v
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['w'] = 5, ['wi'] = 10}, {['w'] = 3}), {['w'] = 3, ['wi'] = 10})
end

os.exit(lu.LuaUnit.run())

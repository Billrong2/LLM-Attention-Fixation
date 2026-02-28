local function f(d)
    local result = {}
    for key, value in pairs(d) do
        result[key] = value
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['a'] = 42, ['b'] = 1337, ['c'] = -1, ['d'] = 5}), {['a'] = 42, ['b'] = 1337, ['c'] = -1, ['d'] = 5})
end

os.exit(lu.LuaUnit.run())

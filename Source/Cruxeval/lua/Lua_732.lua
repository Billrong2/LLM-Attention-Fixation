local function f(char_freq)
    local result = {}
    for k, v in pairs(char_freq) do
        result[k] = math.floor(v / 2)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['u'] = 20, ['v'] = 5, ['b'] = 7, ['w'] = 3, ['x'] = 3}), {['u'] = 10, ['v'] = 2, ['b'] = 3, ['w'] = 1, ['x'] = 1})
end

os.exit(lu.LuaUnit.run())

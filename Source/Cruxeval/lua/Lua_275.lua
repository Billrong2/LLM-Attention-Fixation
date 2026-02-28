local function f(dic)
    local dic2 = {}
    for key, value in pairs(dic) do
        dic2[value] = key
    end
    return dic2
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[-1] = 'a', [0] = 'b', [1] = 'c'}), {['a'] = -1, ['b'] = 0, ['c'] = 1})
end

os.exit(lu.LuaUnit.run())

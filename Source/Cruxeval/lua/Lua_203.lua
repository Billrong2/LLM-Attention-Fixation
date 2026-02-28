local function f(d)
    for k, _ in pairs(d) do
        d[k] = nil
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['a'] = '3', ['b'] = '-1', ['c'] = 'Dum'}), {})
end

os.exit(lu.LuaUnit.run())

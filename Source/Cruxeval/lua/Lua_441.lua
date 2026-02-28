local function f(base, k, v)
    base[k] = v
    return base
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[37] = 'forty-five'}, '23', 'what?'), {[37] = 'forty-five', ['23'] = 'what?'})
end

os.exit(lu.LuaUnit.run())

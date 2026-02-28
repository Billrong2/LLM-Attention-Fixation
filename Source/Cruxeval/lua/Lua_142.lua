local function f(x)
    if string.match(x, "%l+") then
        return x
    else
        return string.reverse(x)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ykdfhp'), 'ykdfhp')
end

os.exit(lu.LuaUnit.run())

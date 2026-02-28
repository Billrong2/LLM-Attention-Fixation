local function f(name)
    return {string.sub(name, 1, 1), string.reverse(string.sub(name, 2, 2))}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('master. '), {'m', 'a'})
end

os.exit(lu.LuaUnit.run())

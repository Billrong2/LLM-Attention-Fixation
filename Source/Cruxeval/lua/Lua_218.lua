local function f(string, sep)
    local cnt = string:match(sep) and #string:match(sep) or 0
    local result = (string .. sep):rep(cnt)
    return result:reverse()
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('caabcfcabfc', 'ab'), 'bacfbacfcbaacbacfbacfcbaac')
end

os.exit(lu.LuaUnit.run())

local function f(x, y)
    local tmp = y:gsub('9', '0'):reverse()
    if (string.match(x, '%d') and string.match(tmp, '%d')) then
        return x .. tmp
    else
        return x
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('', 'sdasdnakjsda80'), '')
end

os.exit(lu.LuaUnit.run())

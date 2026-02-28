local function f(text)
    if text:match('%d+') and text:match('^%d+$') then
        return 'integer'
    end
    return 'string'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(''), 'string')
end

os.exit(lu.LuaUnit.run())

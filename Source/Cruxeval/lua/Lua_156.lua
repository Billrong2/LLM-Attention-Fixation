local function f(text, limit, char)
    if limit < string.len(text) then
        return string.sub(text, 1, limit)
    end
    return string.rep(char, limit - string.len(text)) .. text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('tqzym', 5, 'c'), 'tqzym')
end

os.exit(lu.LuaUnit.run())

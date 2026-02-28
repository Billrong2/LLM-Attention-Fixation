local function f(text, fill, size)
    if size < 0 then
        size = -size
    end
    if string.len(text) > size then
        return string.sub(text, string.len(text) - size + 1)
    end
    return string.rep(fill, size - string.len(text)) .. text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('no asw', 'j', 1), 'w')
end

os.exit(lu.LuaUnit.run())

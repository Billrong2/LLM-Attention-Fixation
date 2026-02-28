local function f(text, search)
    return string.sub(search, 1, string.len(text)) == text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('123', '123eenhas0'), true)
end

os.exit(lu.LuaUnit.run())

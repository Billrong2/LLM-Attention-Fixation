local function f(text, delimiter)
    local newText = text:match("(.+)" .. delimiter .. "(.*)")
    return newText
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('xxjarczx', 'x'), 'xxjarcz')
end

os.exit(lu.LuaUnit.run())

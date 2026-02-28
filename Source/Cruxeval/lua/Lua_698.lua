local function f(text)
    return string.gsub(text, '%)', '')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('(((((((((((d))))))))).))))((((('), '(((((((((((d.(((((')
end

os.exit(lu.LuaUnit.run())

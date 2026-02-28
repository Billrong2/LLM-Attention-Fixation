local function f(text, old, new)
    text2 = string.gsub(text, old, new)
    old2 = string.reverse(old)
    while string.find(text2, old2) do
        text2 = string.gsub(text2, old2, new)
    end
    return text2
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('some test string', 'some', 'any'), 'any test string')
end

os.exit(lu.LuaUnit.run())

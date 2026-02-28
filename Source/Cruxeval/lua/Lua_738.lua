local function f(text, characters)
    for i = 1, string.len(characters) do
        text = string.gsub(text, characters:sub(i, i).."$", "")
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('r;r;r;r;r;r;r;r;r', 'x.r'), 'r;r;r;r;r;r;r;r;')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local new_text = text
    while string.len(text) > 1 and string.sub(text, 1, 1) == string.sub(text, -1) do
        new_text = text
        text = string.sub(text, 2, -2)
    end
    return new_text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(')'), ')')
end

os.exit(lu.LuaUnit.run())

local function f(text, char)
    local new_text = text
    local a = {}
    while string.find(new_text, char) ~= nil do
        table.insert(a, string.find(new_text, char) - 1)
        new_text = string.gsub(new_text, char, '', 1)
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('rvr', 'r'), {0, 1})
end

os.exit(lu.LuaUnit.run())

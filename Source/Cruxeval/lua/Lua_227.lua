local function f(text)
    text = string.lower(text)
    local head, tail = string.sub(text, 1, 1), string.sub(text, 2)
    return string.upper(head) .. tail
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Manolo'), 'Manolo')
end

os.exit(lu.LuaUnit.run())

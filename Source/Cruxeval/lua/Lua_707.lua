local function f(text, position)
    local length = string.len(text)
    local index = position % (length + 1)
    if position < 0 or index < 0 then
        index = -1
    end
    local new_text = {string.byte(text, 1, -1)}
    table.remove(new_text, index + 1)
    return string.char(table.unpack(new_text))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('undbs l', 1), 'udbs l')
end

os.exit(lu.LuaUnit.run())

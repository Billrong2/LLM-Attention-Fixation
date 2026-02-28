local function f(text, position, value)
    local length = string.len(text)
    local index = (position % (length + 2)) - 1
    if index >= length or index < 0 then
        return text
    end
    local text_list = {}
    for i = 1, length do
        text_list[i] = string.sub(text, i, i)
    end
    text_list[index + 1] = value
    return table.concat(text_list)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('1zd', 0, 'm'), '1zd')
end

os.exit(lu.LuaUnit.run())

local function f(text, position, value)
    local length = string.len(text)
    local index = position % length
    if position < 0 then
        index = math.floor(length / 2)
    end
    local new_text = {}
    for i = 1, length do
        table.insert(new_text, string.sub(text, i, i))
    end
    table.insert(new_text, index + 1, value)
    table.remove(new_text, length)
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('sduyai', 1, 'y'), 'syduyi')
end

os.exit(lu.LuaUnit.run())

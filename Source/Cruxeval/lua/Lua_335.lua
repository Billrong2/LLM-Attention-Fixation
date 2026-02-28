local function f(text, to_remove)
    local new_text = {}
    for i = 1, string.len(text) do
        table.insert(new_text, string.sub(text, i, i))
    end
    local index = nil
    for i, v in ipairs(new_text) do
        if v == to_remove then
            index = i
            break
        end
    end
    if index then
        new_text[index] = '?'
        table.remove(new_text, index)
    end
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('sjbrlfqmw', 'l'), 'sjbrfqmw')
end

os.exit(lu.LuaUnit.run())

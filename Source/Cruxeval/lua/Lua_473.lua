local function f(text, value)
    local indexes = {}
    for i = 1, string.len(text) do
        if string.sub(text, i, i) == value then
            table.insert(indexes, i)
        end
    end

    local new_text = {}
    for i = 1, string.len(text) do
        new_text[i] = string.sub(text, i, i)
    end

    for i = #indexes, 1, -1 do
        table.remove(new_text, indexes[i])
    end

    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('scedvtvotkwqfoqn', 'o'), 'scedvtvtkwqfqn')
end

os.exit(lu.LuaUnit.run())

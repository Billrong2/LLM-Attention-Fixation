local function f(text, char)
    local text_table = {}
    for i = 1, #text do
        table.insert(text_table, string.sub(text, i, i))
    end
    
    for i, item in ipairs(text_table) do
        if item == char then
            table.remove(text_table, i)
            return table.concat(text_table)
        end
    end
    
    return text_table
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('pn', 'p'), 'n')
end

os.exit(lu.LuaUnit.run())

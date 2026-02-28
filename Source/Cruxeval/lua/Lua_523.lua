local function f(text)
    local text_table = {}
    for i = #text, 1, -1 do
        if text:sub(i, i) == " " then
            table.insert(text_table, "&nbsp;")
        else
            table.insert(text_table, text:sub(i, i))
        end
    end
    return table.concat(text_table)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('   '), '&nbsp;&nbsp;&nbsp;')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local new_text = {}
    for i = 1, string.len(text) do
        if string.sub(text, i, i) ~= '+' then
            table.insert(new_text, string.sub(text, i, i))
        end
    end
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hbtofdeiequ'), 'hbtofdeiequ')
end

os.exit(lu.LuaUnit.run())

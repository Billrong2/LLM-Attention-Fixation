local function f(text, value)
    local text_list = {}
    for i = 1, string.len(text) do
        table.insert(text_list, string.sub(text, i, i))
    end
    table.insert(text_list, value)
    return table.concat(text_list)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bcksrut', 'q'), 'bcksrutq')
end

os.exit(lu.LuaUnit.run())

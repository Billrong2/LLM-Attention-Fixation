local function f(text)
    local text_arr = {}
    for j=1, string.len(text) do
        table.insert(text_arr, string.sub(text, j))
    end
    return text_arr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('123'), {'123', '23', '3'})
end

os.exit(lu.LuaUnit.run())

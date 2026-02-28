local function f(text)
    local text_list = {}
    for i = 1, #text do
        text_list[i] = string.upper(text:sub(i, i)) ~= text:sub(i, i) and string.upper(text:sub(i, i)) or string.lower(text:sub(i, i))
    end
    return table.concat(text_list)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('akA?riu'), 'AKa?RIU')
end

os.exit(lu.LuaUnit.run())

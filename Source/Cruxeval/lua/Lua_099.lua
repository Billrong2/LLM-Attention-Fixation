local function f(text, sep, num)
    local sep_pos = {}
    local start_pos = 1
    while true do
        local s, e = string.find(text, sep, start_pos, true)
        if s then
            table.insert(sep_pos, s)
            start_pos = e + 1
        else
            break
        end
    end
    local str_parts = {}
    local last_pos = 1
    for i = 1, num do
        local sep_i = sep_pos[#sep_pos - i + 1]
        if sep_i then
            table.insert(str_parts, string.sub(text, last_pos, sep_i - 1))
            last_pos = sep_i + string.len(sep)
        end
    end
    table.insert(str_parts, string.sub(text, last_pos))
    return table.concat(str_parts, '___')
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('aa+++bb', '+', 1), 'aa++___bb')
end

os.exit(lu.LuaUnit.run())

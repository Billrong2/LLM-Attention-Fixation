function f(text, old, new)
    local index = text:find(old)
    local result = {}
    local last_pos = 1
    while index ~= nil and index > 1 do
        table.insert(result, text:sub(last_pos, index - 1))
        table.insert(result, new)
        last_pos = index + #old
        index = text:find(old, last_pos, true)
    end
    table.insert(result, text:sub(last_pos))
    return table.concat(result)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jysrhfm ojwesf xgwwdyr dlrul ymba bpq', 'j', '1'), 'jysrhfm ojwesf xgwwdyr dlrul ymba bpq')
end

os.exit(lu.LuaUnit.run())

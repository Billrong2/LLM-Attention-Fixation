local function f(text, sub)
    local index = {}
    local starting = 1
    while starting ~= nil do
        starting = string.find(text, sub, starting)
        if starting ~= nil then
            table.insert(index, starting)
            starting = starting + string.len(sub)
        end
    end
    return index
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('egmdartoa', 'good'), {})
end

os.exit(lu.LuaUnit.run())

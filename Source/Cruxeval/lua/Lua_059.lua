local function f(s)
    local a = {}
    for i = 1, string.len(s) do
        local char = string.sub(s, i, i)
        if char ~= ' ' then
            table.insert(a, char)
        end
    end
    
    local b = a
    for i = #a, 1, -1 do
        if a[i] == ' ' then
            table.remove(b)
        else
            break
        end
    end
    
    return table.concat(b)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hi '), 'hi')
end

os.exit(lu.LuaUnit.run())

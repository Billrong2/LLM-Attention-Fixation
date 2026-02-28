local function f(text)
    local a = {''}
    local b = ''
    for i=1, #text do
        if not string.match(text:sub(i, i), "%s") then
            table.insert(a, b)
            b = ''
        else
            b = b .. text:sub(i, i)
        end
    end
    return #a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('       '), 1)
end

os.exit(lu.LuaUnit.run())

local function f(doc)
    for i=1, #doc do
        local x = string.sub(doc, i, i)
        if string.match(x, "%a") then
            return string.upper(x)
        end
    end
    return '-'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('raruwa'), 'R')
end

os.exit(lu.LuaUnit.run())

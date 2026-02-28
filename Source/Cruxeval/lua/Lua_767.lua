local function f(text)
    local a = {}
    for word in text:gmatch("%S+") do
        table.insert(a, word)
    end
    for i = 1, #a do
        if not tonumber(a[i]) then
            return '-'
        end
    end
    return table.concat(a, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('d khqw whi fwi bbn 41'), '-')
end

os.exit(lu.LuaUnit.run())

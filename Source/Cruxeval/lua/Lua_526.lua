local function f(label1, char, label2, index)
    local m = string.find(label1, char:reverse(), 1, true) or 0
    if m >= index then
        return string.sub(label2, 1, m - index + 1)
    end
    return label1 .. string.sub(label2, index - m)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ekwies', 's', 'rpg', 1), 'rpg')
end

os.exit(lu.LuaUnit.run())

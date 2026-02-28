local function f(c, st, ed)
    local d = {}
    local a, b = 0, 0
    local w
    for x, y in pairs(c) do
        d[y] = x
        if y == st then
            a = x
        end
        if y == ed then
            b = x
        end
    end
    w = d[st]
    return a > b and {w, b} or {b, w}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['TEXT'] = 7, ['CODE'] = 3}, 7, 3), {'TEXT', 'CODE'})
end

os.exit(lu.LuaUnit.run())

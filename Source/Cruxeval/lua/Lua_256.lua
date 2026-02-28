local function f(text, sub)
    local a = 0
    local b = string.len(text) - 1

    while a <= b do
        local c = math.floor((a + b) / 2)
        if string.find(text:reverse(), sub:reverse(), c, true) then
            a = c + 1
        else
            b = c - 1
        end
    end

    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dorfunctions', '2'), 0)
end

os.exit(lu.LuaUnit.run())

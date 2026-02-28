local function f(n)
    local t = 0
    local b = ''
    local digits = {}
    for i = 1, #tostring(n) do
        table.insert(digits, tonumber(string.sub(tostring(n), i, i)))
    end
    for _, d in pairs(digits) do
        if d == 0 then
            t = t + 1
        else
            break
        end
    end
    for i = 1, t do
        b = b .. '1' .. '0' .. '4'
    end
    b = b .. tostring(n)
    return b
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(372359), '372359')
end

os.exit(lu.LuaUnit.run())

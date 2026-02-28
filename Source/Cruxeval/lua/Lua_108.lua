function f(var)
    local amount = 0
    if type(var) == "table" and #var > 0 then
        amount = #var
    elseif type(var) == "table" and next(var) ~= nil then
        amount = 0
        for _ in pairs(var) do
            amount = amount + 1
        end
    end
    local nonzero = amount > 0 and amount or 0
    return nonzero
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1), 0)
end

os.exit(lu.LuaUnit.run())

local function f(cat)
    local digits = 0
    for i = 1, #cat do
        local char = cat:sub(i, i)
        if tonumber(char) then
            digits = digits + 1
        end
    end
    return digits
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('C24Bxxx982ab'), 5)
end

os.exit(lu.LuaUnit.run())

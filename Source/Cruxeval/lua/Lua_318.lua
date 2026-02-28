local function f(value, char)
    local total = 0
    for i = 1, #value do
        local c = value:sub(i, i)
        if c == char or string.lower(c) == char then
            total = total + 1
        end
    end
    return total
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('234rtccde', 'e'), 1)
end

os.exit(lu.LuaUnit.run())

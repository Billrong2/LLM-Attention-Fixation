local function f(n)
    local streak = ''
    for i = 1, #tostring(n) do
        local c = tostring(n):sub(i, i)
        streak = streak .. c .. string.rep(' ', tonumber(c) * 2 - 1)
    end
    return streak
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1), '1 ')
end

os.exit(lu.LuaUnit.run())

local function f(n)
    n = tostring(n)
    for i = 1, #n do
        local digit = tonumber(n:sub(i, i))
        if digit < 0 or digit > 9 or digit < 5 then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1341240312), false)
end

os.exit(lu.LuaUnit.run())

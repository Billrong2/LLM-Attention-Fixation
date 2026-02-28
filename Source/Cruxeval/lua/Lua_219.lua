local function f(s1, s2)
    for k = 0, string.len(s2) + string.len(s1), 1 do
        s1 = s1 .. string.sub(s1, 1, 1)
        if string.find(s1, s2) then
            return true
        end
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Hello', ')'), false)
end

os.exit(lu.LuaUnit.run())

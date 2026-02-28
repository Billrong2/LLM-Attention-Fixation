local function f(text)
    for i = 1, #text do
        local c = text:sub(i, i)
        if c:byte() > 127 then
            return false
        end
    end
    return true
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct'), false)
end

os.exit(lu.LuaUnit.run())

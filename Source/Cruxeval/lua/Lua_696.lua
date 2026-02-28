local function f(text)
    local s = 0
    for i = 2, #text do
        s = s + #text:sub(1, i-1)
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wdj'), 3)
end

os.exit(lu.LuaUnit.run())

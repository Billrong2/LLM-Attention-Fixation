local function f(text, value)
    return text .. string.rep("?", math.max(0, #value - #text))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('!?', ''), '!?')
end

os.exit(lu.LuaUnit.run())

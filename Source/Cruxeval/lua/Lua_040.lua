local function f(text)
    return text .. string.rep("#", #text + 1 - #text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('the cow goes moo'), 'the cow goes moo#')
end

os.exit(lu.LuaUnit.run())

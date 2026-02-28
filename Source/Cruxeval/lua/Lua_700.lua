local function f(text)
    return string.len(text) - select(2, string.gsub(text, 'bot', ''))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Where is the bot in this world?'), 30)
end

os.exit(lu.LuaUnit.run())

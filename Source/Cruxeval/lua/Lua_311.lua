local function f(text)
    text = text:gsub("#", "1"):gsub("$", "5")
    return text:match("^%d+$") and "yes" or "no"
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('A'), 'no')
end

os.exit(lu.LuaUnit.run())

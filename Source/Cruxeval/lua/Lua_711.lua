local function f(text)
    return text:gsub("\n", "\t")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('apples\n\t\npears\n\t\nbananas'), 'apples\t\t\tpears\t\t\tbananas')
end

os.exit(lu.LuaUnit.run())

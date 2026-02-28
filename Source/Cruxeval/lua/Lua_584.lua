local function f(txt)
    return string.format(txt, string.rep('0', 20))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('5123807309875480094949830'), '5123807309875480094949830')
end

os.exit(lu.LuaUnit.run())

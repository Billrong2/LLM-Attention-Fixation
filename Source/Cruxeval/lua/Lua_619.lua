local function f(title)
    return string.lower(title)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('   Rock   Paper   SCISSORS  '), '   rock   paper   scissors  ')
end

os.exit(lu.LuaUnit.run())

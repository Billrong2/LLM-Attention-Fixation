local function f(challenge)
    return challenge:lower():gsub('l', ',')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('czywZ'), 'czywz')
end

os.exit(lu.LuaUnit.run())

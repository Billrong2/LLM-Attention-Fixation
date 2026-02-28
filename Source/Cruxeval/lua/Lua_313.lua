local function f(s, l)
    return string.sub(s .. string.rep('=', l), 1, string.find(s .. string.rep('=', l), '=') - 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('urecord', 8), 'urecord')
end

os.exit(lu.LuaUnit.run())

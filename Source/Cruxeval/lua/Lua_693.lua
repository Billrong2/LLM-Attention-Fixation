local function f(text)
    local n = string.find(text, '8') - 1
    if n < 0 then
        n = 0
    end
    return string.rep('x0', n)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('sa832d83r xd 8g 26a81xdf'), 'x0x0')
end

os.exit(lu.LuaUnit.run())

local function f(num, name)
    local f_str = 'quiz leader = %s, count = %d'
    return string.format(f_str, name, num)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(23, 'Cornareti'), 'quiz leader = Cornareti, count = 23')
end

os.exit(lu.LuaUnit.run())

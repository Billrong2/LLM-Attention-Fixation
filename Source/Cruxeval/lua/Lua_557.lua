local function f(s)
    local d = {}
    d[1], d[2], d[3] = string.match(s, "(.*)(.*ar)(.*)$")
    return d[1] .. ' ' .. d[2] .. ' ' .. d[3]
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('xxxarmmarxx'), 'xxxarmm ar xx')
end

os.exit(lu.LuaUnit.run())

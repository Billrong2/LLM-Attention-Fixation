local function f(s)
    if string.match(s, "^%w+$") then
        return "True"
    end
    return "False"
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('777'), 'True')
end

os.exit(lu.LuaUnit.run())

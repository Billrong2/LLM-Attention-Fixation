local function f(string)
    local count = string:gsub(":", ""):len()
    return string:gsub(":", "", count - 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('1::1'), '1:1')
end

os.exit(lu.LuaUnit.run())

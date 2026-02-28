local function f(n)
    n = tostring(n)
    return string.sub(n, 1, 1) .. '.' .. string.gsub(string.sub(n, 2), '-', '_')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('first-second-third'), 'f.irst_second_third')
end

os.exit(lu.LuaUnit.run())

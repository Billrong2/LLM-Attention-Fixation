local function f(num, l)
    local t = ""
    while l > string.len(num) do
        t = t .. '0'
        l = l - 1
    end
    return t .. num
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('1', 3), '001')
end

os.exit(lu.LuaUnit.run())

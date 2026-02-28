local function f(integer, n)
    local i = 1
    local text = tostring(integer)
    while i + #text < n do
        i = i + #text
    end
    return string.format("%0" .. i + #text .. "d", integer)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(8999, 2), '08999')
end

os.exit(lu.LuaUnit.run())

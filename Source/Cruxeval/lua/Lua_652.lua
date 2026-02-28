local function f(string)
    if not string or not tonumber(string:sub(1, 1)) then
        return 'INVALID'
    end
    local cur = 0
    for i = 1, string:len() do
        cur = cur * 10 + tonumber(string:sub(i, i))
    end
    return tostring(cur)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('3'), '3')
end

os.exit(lu.LuaUnit.run())

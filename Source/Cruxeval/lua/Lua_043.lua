local function f(n)
    for i = 1, #n do
        local c = n:sub(i, i)
        if c < '0' or c > '9' then
            return -1
        end
    end
    return n
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('6 ** 2'), -1)
end

os.exit(lu.LuaUnit.run())

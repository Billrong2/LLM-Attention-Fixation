local function f(num)
    local s = string.rep('<', 10)
    if num % 2 == 0 then
        return s
    else
        return num - 1
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(21), 20)
end

os.exit(lu.LuaUnit.run())

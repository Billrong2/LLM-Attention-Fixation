local function f(n)
    local p = ''
    if n % 2 == 1 then
        p = p .. 'sn'
    else
        return n * n
    end
    for x = 1, n do
        if x % 2 == 0 then
            p = p .. 'to'
        else
            p = p .. 'ts'
        end
    end
    return p
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1), 'snts')
end

os.exit(lu.LuaUnit.run())

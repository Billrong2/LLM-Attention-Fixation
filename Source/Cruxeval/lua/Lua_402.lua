local function f(n, l)
    local archive = {}
    for i=1, n do
        archive = {}
        for _, x in pairs(l) do
            archive[x + 10] = x * 10
        end
    end
    return archive
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(0, {'aaa', 'bbb'}), {})
end

os.exit(lu.LuaUnit.run())

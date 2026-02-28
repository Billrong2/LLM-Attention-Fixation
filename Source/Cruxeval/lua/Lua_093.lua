local function f(n)
    local length = string.len(n) + 2
    local revn = {}
    for i = 1, string.len(n) do
        table.insert(revn, string.sub(n, i, i))
    end
    local result = table.concat(revn)
    revn = {}
    return result .. string.rep("!", length)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('iq'), 'iq!!!!')
end

os.exit(lu.LuaUnit.run())

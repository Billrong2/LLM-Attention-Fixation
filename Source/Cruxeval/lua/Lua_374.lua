local function f(seq, v)
    local a = {}
    for i=1, #seq do
        if string.sub(seq[i], -string.len(v)) == v then
            table.insert(a, seq[i]..seq[i])
        end
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'oH', 'ee', 'mb', 'deft', 'n', 'zz', 'f', 'abA'}, 'zz'), {'zzzz'})
end

os.exit(lu.LuaUnit.run())

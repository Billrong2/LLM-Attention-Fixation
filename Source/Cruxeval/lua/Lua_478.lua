local function f(sb)
    local d = {}
    for i = 1, string.len(sb) do
        local s = string.sub(sb, i, i)
        d[s] = (d[s] or 0) + 1
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('meow meow'), {['m'] = 2, ['e'] = 2, ['o'] = 2, ['w'] = 2, [' '] = 1})
end

os.exit(lu.LuaUnit.run())

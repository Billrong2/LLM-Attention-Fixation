local function f(value)
    local ls = {}
    for i = 1, string.len(value) do
        table.insert(ls, string.sub(value, i, i))
    end
    table.insert(ls, 'NHIB')
    return table.concat(ls)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ruam'), 'ruamNHIB')
end

os.exit(lu.LuaUnit.run())

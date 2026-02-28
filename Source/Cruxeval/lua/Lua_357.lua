local function f(s)
    local r = {}
    for i = string.len(s), 1, -1 do
        table.insert(r, string.sub(s, i, i))
    end
    return table.concat(r)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('crew'), 'werc')
end

os.exit(lu.LuaUnit.run())

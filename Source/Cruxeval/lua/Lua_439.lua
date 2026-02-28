local function f(value)
    local parts = {}
    for part in string.gmatch(value, "([^ ]+)") do
        table.insert(parts, part)
    end
    return table.concat(parts)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('coscifysu'), 'coscifysu')
end

os.exit(lu.LuaUnit.run())

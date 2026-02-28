local function f(a)
    local s = {}
    local items = {}
    for k, v in pairs(a) do
        table.insert(items, {k, v})
    end
    for i = #items, 1, -1 do
        s[items[i][1]] = items[i][2]
    end
    local output = {}
    for k, v in pairs(s) do
        table.insert(output, string.format("(%s, '%s')", k, v))
    end
    return table.concat(output, " ")
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[15] = 'Qltuf', [12] = 'Rwrepny'}), "(12, 'Rwrepny') (15, 'Qltuf')")
end

os.exit(lu.LuaUnit.run())

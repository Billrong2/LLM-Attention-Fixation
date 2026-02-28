local function f(text, chars)
    local result = {}
    for i = 1, string.len(text) do
        table.insert(result, string.sub(text, i, i))
    end
    while #result >= 3 and string.sub(text, -3) == chars do
        table.remove(result, -3)
        table.remove(result, -3)
    end
    return table.concat(result):gsub('^%s*(.-)%s*$', '%1')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ellod!p.nkyp.exa.bi.y.hain', '.n.in.ha.y'), 'ellod!p.nkyp.exa.bi.y.hain')
end

os.exit(lu.LuaUnit.run())

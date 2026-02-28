local function f(x)
    local chars = {}
    for i = #x, 1, -1 do
        table.insert(chars, string.sub(x, i, i))
    end
    return table.concat(chars, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('lert dna ndqmxohi3'), '3 i h o x m q d n   a n d   t r e l')
end

os.exit(lu.LuaUnit.run())

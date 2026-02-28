local function f(letters, maxsplit)
    local words = {}
    for word in string.gmatch(letters, "%S+") do
        table.insert(words, word)
    end
    local count = math.min(maxsplit, #words)
    local result = ''
    for i = #words - count + 1, #words do
        result = result .. words[i]
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('elrts,SS ee', 6), 'elrts,SSee')
end

os.exit(lu.LuaUnit.run())

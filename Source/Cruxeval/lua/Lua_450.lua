local function f(strs)
    local words = {}
    for word in string.gmatch(strs, "%S+") do
        table.insert(words, word)
    end
    for i = 2, #words, 2 do
        words[i] = string.reverse(words[i])
    end
    return table.concat(words, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('K zBK'), 'K KBz')
end

os.exit(lu.LuaUnit.run())

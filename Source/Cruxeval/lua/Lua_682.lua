local function f(text, length, index)
    local ls = string.gmatch(text, "%S+")
    local words = {}
    for word in ls do
        table.insert(words, string.sub(word, 1, length))
    end
    return table.concat(words, "_")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hypernimovichyp', 2, 2), 'hy')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local words = {}
    for word in text:gmatch("%S+") do
        table.insert(words, word:match("^%s*(.-)$"))
    end
    return table.concat(words, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('pvtso'), 'pvtso')
end

os.exit(lu.LuaUnit.run())

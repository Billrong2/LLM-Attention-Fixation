local function f(name)
    local words = {}
    for word in string.gmatch(name, "%S+") do
        table.insert(words, word)
    end
    return table.concat(words, '*')
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Fred Smith'), 'Fred*Smith')
end

os.exit(lu.LuaUnit.run())

local function f(text, splitter)
    local words = {}
    for word in string.gmatch(text:lower(), "%S+") do
        table.insert(words, word)
    end
    return table.concat(words, splitter)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('LlTHH sAfLAPkPhtsWP', '#'), 'llthh#saflapkphtswp')
end

os.exit(lu.LuaUnit.run())

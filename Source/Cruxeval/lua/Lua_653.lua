local function f(text, letter)
    local t = text:gsub("["..letter.."]", "")
    local words = {}
    for w in string.gmatch(t, "[^"..letter.."]+") do
        table.insert(words, w)
    end
    return #words
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('c, c, c ,c, c', 'c'), 1)
end

os.exit(lu.LuaUnit.run())

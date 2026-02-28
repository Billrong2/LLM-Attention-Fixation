local function f(text)
    local words = {}
    for word in text:gmatch("%S+") do
        table.insert(words, word)
    end
    for i, word in ipairs(words) do
        if not tonumber(word) then
            return 'no'
        end
    end
    return 'yes'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('03625163633 d'), 'no')
end

os.exit(lu.LuaUnit.run())

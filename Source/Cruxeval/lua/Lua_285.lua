local function f(text, ch)
    -- Counting vowels in Pirates' Curse
    local count = 0
    for i = 1, #text do
        if text:sub(i, i) == ch then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate("This be Pirate's Speak for 'help'!", ' '), 5)
end

os.exit(lu.LuaUnit.run())

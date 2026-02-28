local function f(text, speaker)
    while text:sub(1, speaker:len()) == speaker do
        text = text:sub(speaker:len() + 1)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('[CHARRUNNERS]Do you know who the other was? [NEGMENDS]', '[CHARRUNNERS]'), 'Do you know who the other was? [NEGMENDS]')
end

os.exit(lu.LuaUnit.run())

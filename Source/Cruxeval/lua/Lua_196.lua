local function f(text)
    text = text:gsub(' x', ' x.')
    if text:sub(1, 1):upper() == text:sub(1, 1) then
        return 'correct'
    end
    text = text:gsub(' x.', ' x')
    return 'mixed'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('398 Is A Poor Year To Sow'), 'correct')
end

os.exit(lu.LuaUnit.run())

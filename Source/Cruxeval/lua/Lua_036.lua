local function f(text, chars)
    if text then
        local chars_len = string.len(chars)
        local trimmed = text
        for i = 1, chars_len do
            local char = string.sub(chars, i, i)
            while string.sub(trimmed, -1) == char do
                trimmed = string.sub(trimmed, 1, -2)
            end
        end
        return trimmed
    else
        return text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ha', ''), 'ha')
end

os.exit(lu.LuaUnit.run())

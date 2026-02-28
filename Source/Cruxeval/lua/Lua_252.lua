local function f(text, char)
    if string.find(text, char, 1, true) then
        if text:sub(1, 1) ~= char then
            text = text:gsub(char, '')
        end
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('\\foo', '\\'), '\\foo')
end

os.exit(lu.LuaUnit.run())

local function f(text, letter)
    if letter:lower() ~= letter then
        letter = letter:upper()
    end
    local result = ""
    for i = 1, #text do
        local char = text:sub(i, i)
        if char:lower() == letter:lower() then
            result = result .. letter
        else
            result = result .. char
        end
    end
    return result:gsub("^%l", string.upper)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('E wrestled evil until upperfeat', 'e'), 'E wrestled evil until upperfeat')
end

os.exit(lu.LuaUnit.run())

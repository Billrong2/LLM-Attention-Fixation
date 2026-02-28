local function f(text)
    local punctuations = {'!', '.', '?', ',', ':', ';'}
    for _, punct in ipairs(punctuations) do
        if string.len(text:lower():gsub("[^"..punct.."]", "")) > 1 then
            return 'no'
        end
        if text:sub(-1) == punct then
            return 'no'
        end
    end
    return text:gsub("^%l", string.upper)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('djhasghasgdha'), 'Djhasghasgdha')
end

os.exit(lu.LuaUnit.run())

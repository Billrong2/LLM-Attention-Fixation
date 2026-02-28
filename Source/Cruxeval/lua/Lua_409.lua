local function f(text, char)
    if text ~= nil then
        text = text:gsub("^" .. char, "")
        text = text:gsub("^" .. string.sub(text, -1), "")
        text = string.sub(text, 1, -2) .. string.upper(string.sub(text, -1))
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('querist', 'u'), 'querisT')
end

os.exit(lu.LuaUnit.run())

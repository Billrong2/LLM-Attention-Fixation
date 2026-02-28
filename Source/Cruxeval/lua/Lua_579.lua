local function f(text)
    if text:sub(1,1):upper() == text:sub(1,1) and text:lower() ~= text and #text > 1 then
        return text:sub(1,1):lower() .. text:sub(2)
    elseif text:match("^[A-Za-z]+$") then
        return text:gsub("^%l", string.upper)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(''), '')
end

os.exit(lu.LuaUnit.run())

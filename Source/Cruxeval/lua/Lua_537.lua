local function f(text, value)
    local new_text = {string.byte(text, 1, #text)}
    local success, _ = pcall(function()
        table.insert(new_text, value)
    end)
    
    local length = success and #new_text or 0
    return "[" .. tostring(length) .. "]"
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abv', 'a'), '[4]')
end

os.exit(lu.LuaUnit.run())

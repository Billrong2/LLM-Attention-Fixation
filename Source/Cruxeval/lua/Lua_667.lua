local function f(text)
    local new_text = {}
    local text_length = string.len(text)
    
    for i=0, math.floor(text_length / 3) - 1 do
        local substr = string.sub(text, i * 3 + 1, i * 3 + 3)
        table.insert(new_text, "< " .. substr .. " level=" .. i .. " >")
    end
    
    local last_item = string.sub(text, math.floor(text_length / 3) * 3 + 1)
    table.insert(new_text, "< " .. last_item .. " level=" .. math.floor(text_length / 3) .. " >")
    
    return new_text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('C7'), {'< C7 level=0 >'})
end

os.exit(lu.LuaUnit.run())

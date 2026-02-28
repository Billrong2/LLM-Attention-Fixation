local function f(text)
    local new_text = ''
    text = text:lower():gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
    for i = 1, #text do
        local ch = text:sub(i, i)
        if ch:match("%d") or ch:match("[ÄäÏïÖöÜü]") then
            new_text = new_text .. ch
        end
    end
    return new_text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(''), '')
end

os.exit(lu.LuaUnit.run())

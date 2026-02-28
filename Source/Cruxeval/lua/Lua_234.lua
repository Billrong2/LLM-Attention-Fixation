local function f(text, char)
    local position = string.len(text)
    local found = string.find(text, char, 1, true)
    if found then
        position = found - 1
        if position > 0 then
            position = (position + 1) % string.len(text)
        end
    end
    return position
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wduhzxlfk', 'w'), 0)
end

os.exit(lu.LuaUnit.run())

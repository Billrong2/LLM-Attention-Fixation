local function f(text, changes)
    local result = ''
    local count = 0
    local changes_list = {string.byte(changes, 1, -1)}
    for i = 1, #text do
        local char = text:sub(i, i)
        if char == 'e' then
            result = result .. char
        else
            result = result .. string.char(changes_list[(count % #changes_list) + 1])
        end
        count = count + (char ~= 'e' and 1 or 0)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('fssnvd', 'yes'), 'yesyes')
end

os.exit(lu.LuaUnit.run())

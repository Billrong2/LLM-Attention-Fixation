local function f(mess, char)
    local last_occurrence = string.len(mess)
    while mess:find(char, last_occurrence + 1) ~= nil do
        last_occurrence = mess:find(char, last_occurrence + 1)
        mess = mess:sub(1, last_occurrence) .. mess:sub(last_occurrence + 2)
    end
    return mess
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('0aabbaa0b', 'a'), '0aabbaa0b')
end

os.exit(lu.LuaUnit.run())

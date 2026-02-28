local function f(perc, full)
    local reply = ""
    local i = 1
    while i <= string.len(full) and i <= string.len(perc) and string.sub(perc, i, i) == string.sub(full, i, i) do
        if string.sub(perc, i, i) == string.sub(full, i, i) then
            reply = reply .. "yes "
        else
            reply = reply .. "no "
        end
        i = i + 1
    end
    return reply
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('xabxfiwoexahxaxbxs', 'xbabcabccb'), 'yes ')
end

os.exit(lu.LuaUnit.run())

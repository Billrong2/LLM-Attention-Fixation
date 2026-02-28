local function f(text)
    local count = string.len(text)
    for i = -count+1, 0 do
        text = text .. string.sub(text, i, i)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wlace A'), 'wlace Alc l  ')
end

os.exit(lu.LuaUnit.run())

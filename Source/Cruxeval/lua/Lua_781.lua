local function f(s, ch)
    if not string.find(s, ch, 1, true) then
        return ''
    end
    local s = string.sub(s, string.find(s, ch) + 1):reverse()
    for i = 1, #s do
        s = string.sub(s, string.find(s, ch) + 1):reverse()
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('shivajimonto6', '6'), '')
end

os.exit(lu.LuaUnit.run())

local function f(text, char)
    local count = select(2, text:gsub(char .. char, ""))
    return text:sub(count + 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('vzzv2sg', 'z'), 'zzv2sg')
end

os.exit(lu.LuaUnit.run())

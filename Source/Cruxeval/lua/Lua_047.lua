local function f(text)
    local length = string.len(text)
    local half = math.floor(length / 2)
    local encode = string.sub(text, 1, half):byte()
    if text:sub(half + 1) == string.char(encode) then
        return true
    else
        return false
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bbbbr'), false)
end

os.exit(lu.LuaUnit.run())

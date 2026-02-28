local function f(text, length, fillchar)
    local size = string.len(text)
    if size >= length then
        return text
    end
    local start = math.ceil((length - size) / 2)
    return string.rep(fillchar, start) .. text .. string.rep(fillchar, math.floor((length - size) / 2))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('magazine', 25, '.'), '.........magazine........')
end

os.exit(lu.LuaUnit.run())

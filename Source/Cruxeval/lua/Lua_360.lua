local function f(text, n)
    if string.len(text) <= 2 then
        return text
    end
    local leading_chars = string.rep(text:sub(1, 1), n - string.len(text) + 1)
    return leading_chars .. text:sub(2, -2) .. text:sub(-1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('g', 15), 'g')
end

os.exit(lu.LuaUnit.run())

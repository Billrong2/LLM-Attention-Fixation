local function f(text)
    text = string.lower(text)
    local capitalize = text:gsub("^%l", string.upper)
    return text:sub(1, 1) .. capitalize:sub(2)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('this And cPanel'), 'this and cpanel')
end

os.exit(lu.LuaUnit.run())

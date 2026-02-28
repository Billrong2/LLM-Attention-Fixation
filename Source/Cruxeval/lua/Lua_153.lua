local function f(text, suffix, num)
    local str_num = tostring(num)
    return text:sub(-(#suffix + #str_num)) == suffix .. str_num
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('friends and love', 'and', 3), false)
end

os.exit(lu.LuaUnit.run())

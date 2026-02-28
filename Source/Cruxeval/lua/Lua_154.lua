local function f(s, c)
    s = string.gmatch(s, "%S+")
    local reversed_s = {}
    for word in s do
        table.insert(reversed_s, 1, word)
    end
    return c .. "  " .. table.concat(reversed_s, "  ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Hello There', '*'), '*  There  Hello')
end

os.exit(lu.LuaUnit.run())

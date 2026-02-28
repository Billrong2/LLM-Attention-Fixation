local function f(text, digit)
    local count = string.len(string.gsub(text, "[^" .. digit .. "]", ""))
    return tonumber(digit) * count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('7Ljnw4Lj', '7'), 7)
end

os.exit(lu.LuaUnit.run())

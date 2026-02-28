local function f(text, num_digits)
    local width = math.max(1, num_digits)
    return string.format("%0" .. width .. "d", text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('19', 5), '00019')
end

os.exit(lu.LuaUnit.run())

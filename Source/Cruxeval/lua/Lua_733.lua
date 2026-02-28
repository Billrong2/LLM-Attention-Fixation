local function f(text)
    local length = math.floor(string.len(text) / 2)
    local left_half = string.sub(text, 1, length)
    local right_half = string.sub(text, length + 1):reverse()
    return left_half .. right_half
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('n'), 'n')
end

os.exit(lu.LuaUnit.run())

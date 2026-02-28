local function f(text, value)
    local length = string.len(text)
    local index = 1
    while length > 0 do
        value = string.sub(text, index, index) .. value
        length = length - 1
        index = index + 1
    end
    return value
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jao mt', 'house'), 'tm oajhouse')
end

os.exit(lu.LuaUnit.run())

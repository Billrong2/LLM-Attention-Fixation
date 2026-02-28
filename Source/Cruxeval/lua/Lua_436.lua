local function f(s, characters)
    local result = {}
    for i = 1, #characters do
        table.insert(result, string.sub(s, characters[i] + 1, characters[i] + 1))
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('s7 6s 1ss', {1, 3, 6, 1, 2}), {'7', '6', '1', '7', ' '})
end

os.exit(lu.LuaUnit.run())

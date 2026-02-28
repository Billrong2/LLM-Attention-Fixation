local function f(text, char)
    for i = #text, 1, -1 do
        if string.sub(text, i, i) == char then
            return i - 1
        end
    end
    return -1
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('breakfast', 'e'), 2)
end

os.exit(lu.LuaUnit.run())

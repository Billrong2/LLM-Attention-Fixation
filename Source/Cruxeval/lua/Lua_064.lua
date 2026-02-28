local function f(text, size)
    local counter = string.len(text)
    for i = 1, size - size % 2 do
        text = ' ' .. text .. ' '
        counter = counter + 2
        if counter >= size then
            return text
        end
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('7', 10), '     7     ')
end

os.exit(lu.LuaUnit.run())

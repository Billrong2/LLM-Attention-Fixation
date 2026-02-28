local function f(text, length)
    length = length < 0 and -length or length
    local output = ''
    for idx = 1, length do
        if text:sub((idx - 1) % #text + 1, (idx - 1) % #text + 1) ~= ' ' then
            output = output .. text:sub((idx - 1) % #text + 1, (idx - 1) % #text + 1)
        else
            break
        end
    end
    return output
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('I got 1 and 0.', 5), 'I')
end

os.exit(lu.LuaUnit.run())

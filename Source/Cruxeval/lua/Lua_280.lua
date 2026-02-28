local g, field = nil, nil

local function f(text)
    g, field = nil, nil
    field = text:gsub(' ', '')
    g = text:gsub('0', ' ')
    text = text:gsub('1', 'i')

    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('00000000 00000000 01101100 01100101 01101110'), '00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0')
end

os.exit(lu.LuaUnit.run())

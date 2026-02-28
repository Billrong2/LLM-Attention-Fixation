local function f(text, value)
    if not string.find(text, value, 1, true) then
        return ''
    end
    return string.match(text, '^(.-)' .. value)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mmfbifen', 'i'), 'mmfb')
end

os.exit(lu.LuaUnit.run())

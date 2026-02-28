local function f(st)
    st = string.lower(st)
    local h_index = string.find(st, 'h', 1, true)
    local i_index = string.find(st, 'i', 1, true)
    if string.find(st, 'h', i_index, true) >= i_index then
        return 'Hey'
    else
        return 'Hi'
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Hi there'), 'Hey')
end

os.exit(lu.LuaUnit.run())

local function f(array)
    local s = ' '
    s = s .. table.concat(array)
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({' ', '  ', '    ', '   '}), '           ')
end

os.exit(lu.LuaUnit.run())

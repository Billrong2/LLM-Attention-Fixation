local function f(text)
    local lines = {}
    for line in string.gmatch(text, '([^\n]+)') do
        table.insert(lines, line)
    end
    return table.concat(lines, ', ')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('BYE\nNO\nWAY'), 'BYE, NO, WAY')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    if string.match(text, "[%z\128-\255]") then
        return 'non ascii'
    else
        return 'ascii'
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('<<<<'), 'ascii')
end

os.exit(lu.LuaUnit.run())

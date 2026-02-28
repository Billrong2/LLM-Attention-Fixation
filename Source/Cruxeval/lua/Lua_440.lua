local function f(text)
    if tonumber(text) ~= nil then
        return 'yes'
    else
        return 'no'
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abc'), 'no')
end

os.exit(lu.LuaUnit.run())

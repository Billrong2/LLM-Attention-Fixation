local function f(n)
    if string.find(tostring(n), '%.') ~= nil then
        return tostring(tonumber(n) + 2.5)
    end
    return tostring(n)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('800'), '800')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    for i=1, #text do
        if not tonumber(text:sub(i, i)) then
            return false
        end
    end
    return #text > 0
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('99'), true)
end

os.exit(lu.LuaUnit.run())

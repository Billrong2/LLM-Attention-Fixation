local function f(text)
    if string.match(text, "%l") ~= nil then
        return true
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('54882'), false)
end

os.exit(lu.LuaUnit.run())

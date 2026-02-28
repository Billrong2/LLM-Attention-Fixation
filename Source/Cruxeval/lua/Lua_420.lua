local function f(text)
    local success, result = pcall(function()
        return text:match("^%a+$") ~= nil
    end)
    return success and result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('x'), true)
end

os.exit(lu.LuaUnit.run())

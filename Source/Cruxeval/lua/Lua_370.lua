local function f(text)
    for i = 1, #text do
        local char = text:sub(i, i)
        if char ~= " " then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('     i'), false)
end

os.exit(lu.LuaUnit.run())

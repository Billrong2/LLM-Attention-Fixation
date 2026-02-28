local function f(text)
    local endings = {'.', '!', '?'}
    for i = 1, #endings do
        if text:sub(-1) == endings[i] then
            return true
        end
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('. C.'), true)
end

os.exit(lu.LuaUnit.run())

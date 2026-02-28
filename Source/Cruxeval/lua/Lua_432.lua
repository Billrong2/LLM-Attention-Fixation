local function f(length, text)
    if string.len(text) == length then
        return string.reverse(text)
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(-5, 'G5ogb6f,c7e.EMm'), false)
end

os.exit(lu.LuaUnit.run())

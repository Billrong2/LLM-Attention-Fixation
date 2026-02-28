local function f(text, dng)
    if string.find(text, dng) == nil then
        return text
    end
    if string.sub(text, -string.len(dng)) == dng then
        return string.sub(text, 1, -string.len(dng) - 1)
    end
    return string.sub(text, 1, -2) .. f(string.sub(text, 1, -3), dng)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('catNG', 'NG'), 'cat')
end

os.exit(lu.LuaUnit.run())

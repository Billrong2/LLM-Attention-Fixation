local function f(text)
    if text == '42.42' then
        return true
    end
    for i = 4, string.len(text) - 3 do
        if string.sub(text, i, i) == '.' and tonumber(string.sub(text, i - 3)) and tonumber(string.sub(text, 1, i - 1)) then
            return true
        end
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('123E-10'), false)
end

os.exit(lu.LuaUnit.run())

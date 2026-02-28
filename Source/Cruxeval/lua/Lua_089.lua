local function f(char)
    if string.find('aeiouAEIOU', char, 1, true) == nil then
        return nil
    end
    if string.find('AEIOU', char, 1, true) then
        return string.lower(char)
    end
    return string.upper(char)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('o'), 'O')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    for i=1, string.len(text) do
        if string.sub(text, i, i) == string.upper(string.sub(text, i, i)) and string.sub(text, i-1, i-1) == string.lower(string.sub(text, i-1, i-1)) then
            return true
        end
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jh54kkk6'), true)
end

os.exit(lu.LuaUnit.run())

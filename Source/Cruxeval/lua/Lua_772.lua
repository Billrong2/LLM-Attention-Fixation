local function f(phrase)
    local result = ''
    for i = 1, #phrase do
        if string.byte(phrase, i) < 97 or string.byte(phrase, i) > 122 then
            result = result .. string.sub(phrase, i, i)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('serjgpoDFdbcA.'), 'DFA.')
end

os.exit(lu.LuaUnit.run())

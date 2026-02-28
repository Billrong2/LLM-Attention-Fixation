local function f(text)
    local s = string.lower(text)
    for i=1, string.len(s) do
        if string.sub(s, i, i) == 'x' then
            return 'no'
        end
    end
    return string.upper(text) == text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dEXE'), 'no')
end

os.exit(lu.LuaUnit.run())

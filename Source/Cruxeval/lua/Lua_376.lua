local function f(text)
    for i=1, #text do
        if string.sub(text, 1, i):sub(1, 3) == "two" then
            return string.sub(text, i+1)
        end
    end
    return 'no'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('2two programmers'), 'no')
end

os.exit(lu.LuaUnit.run())

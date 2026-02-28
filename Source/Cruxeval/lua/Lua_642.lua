local function f(text)
    local i = 1
    while i <= string.len(text) and string.sub(text, i, i):find("%s") do
        i = i + 1
    end
    if i > string.len(text) then
        return 'space'
    end
    return 'no'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('     '), 'space')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local counter = 0
    for i = 1, string.len(text) do
        if string.sub(text, i, i):match('%a') then
            counter = counter + 1
        end
    end
    return counter
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('l000*'), 1)
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local number = 0
    for i=1, string.len(text) do
        if string.sub(text, i, i):match("%d") then
            number = number + 1
        end
    end
    return number
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Thisisastring'), 0)
end

os.exit(lu.LuaUnit.run())

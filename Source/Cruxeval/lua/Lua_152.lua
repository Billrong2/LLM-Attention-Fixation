local function f(text)
    local n = 0
    for i = 1, string.len(text) do
        local char = string.sub(text, i, i)
        if char:match("%u") then
            n = n + 1
        end
    end
    return n
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('AAAAAAAAAAAAAAAAAAAA'), 20)
end

os.exit(lu.LuaUnit.run())

local function f(text)
    for i = 1, string.len(text) do
        if string.match(text:sub(i, i), "%u") then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('lunabotics'), true)
end

os.exit(lu.LuaUnit.run())

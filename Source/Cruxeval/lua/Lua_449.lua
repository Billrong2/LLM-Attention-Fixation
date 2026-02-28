local function f(x)
    local n = string.len(x)
    local i = 1
    while i <= n and tonumber(string.sub(x, i, i)) ~= nil do
        i = i + 1
    end
    return i == n + 1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('1'), true)
end

os.exit(lu.LuaUnit.run())

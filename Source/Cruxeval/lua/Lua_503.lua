local function f(d)
    local result = {}
    local a, b = 1, 1
    while next(d) ~= nil do
        result[a] = {next(d)}
        a, b = b, (b % #result) + 1
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

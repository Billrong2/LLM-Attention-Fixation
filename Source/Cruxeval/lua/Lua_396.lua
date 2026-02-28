local function f(ets)
    while next(ets) ~= nil do
        local k, v = next(ets)
        ets[k] = v^2
        ets[k] = nil
    end
    return ets
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

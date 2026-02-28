local function f(t)
    for i = 1, string.len(t) do
        if not tonumber(string.sub(t, i, i)) then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('#284376598'), false)
end

os.exit(lu.LuaUnit.run())

local function f(m)
    for i = 1, math.floor(#m / 2) do
        m[i], m[#m - i + 1] = m[#m - i + 1], m[i]
    end
    return m
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-4, 6, 0, 4, -7, 2, -1}), {-1, 2, -7, 4, 0, 6, -4})
end

os.exit(lu.LuaUnit.run())

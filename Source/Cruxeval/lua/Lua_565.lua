local function f(text)
    local positions = {a = -1, e = -1, i = -1, o = -1, u = -1}
    for i = 1, string.len(text) do
        local ch = string.sub(text, i, i)
        if positions[ch] == -1 then
            positions[ch] = i - 1
        end
    end
    return math.max(positions.a, positions.e, positions.i, positions.o, positions.u)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qsqgijwmmhbchoj'), 13)
end

os.exit(lu.LuaUnit.run())

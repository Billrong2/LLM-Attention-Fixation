local function f(selfie)
    local lo = #selfie
    local i = lo
    while i >= 1 do
        if selfie[i] == selfie[1] then
            table.remove(selfie, lo)
        end
        i = i - 1
    end
    return selfie
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({4, 2, 5, 1, 3, 2, 6}), {4, 2, 5, 1, 3, 2})
end

os.exit(lu.LuaUnit.run())

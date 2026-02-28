local function f(L)
    local N = #L
    for k = 1, math.floor(N/2) do
        local i = k
        local j = N - k + 1
        while i < j do
            -- swap elements:
            L[i], L[j] = L[j], L[i]
            -- update i, j:
            i = i + 1
            j = j - 1
        end
    end
    return L
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({16, 14, 12, 7, 9, 11}), {11, 14, 7, 12, 9, 16})
end

os.exit(lu.LuaUnit.run())

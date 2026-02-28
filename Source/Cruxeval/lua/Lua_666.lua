local function f(d1, d2)
    local mmax = 0
    for k1, v1 in pairs(d1) do
        local p = #v1 + #(d2[k1] or {})
        if p > mmax then
            mmax = p
        end
    end
    return mmax
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[0] = {}, [1] = {}}, {[0] = {0, 0, 0, 0}, [2] = {2, 2, 2}}), 4)
end

os.exit(lu.LuaUnit.run())

local function f(base, delta)
    for j = 1, #delta do
        for i = 1, #base do
            if base[i] == delta[j][1] then
                assert(delta[j][2] ~= base[i], "Assertion failed: delta value should not equal base value.")
                base[i] = delta[j][2]
            end
        end
    end
    return base
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'gloss', 'banana', 'barn', 'lawn'}, {}), {'gloss', 'banana', 'barn', 'lawn'})
end

os.exit(lu.LuaUnit.run())

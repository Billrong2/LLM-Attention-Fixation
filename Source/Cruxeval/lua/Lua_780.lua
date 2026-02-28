local function f(ints)
    local counts = {}
    for i = 1, 301 do
        counts[i] = 0
    end

    for i = 1, #ints do
        counts[ints[i]] = counts[ints[i]] + 1
    end

    local r = {}
    for i = 1, #counts do
        if counts[i] >= 3 then
            table.insert(r, tostring(i))
        end
    end
    counts = nil
    return table.concat(r, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 3, 5, 2, 4, 5, 2, 89}), '2')
end

os.exit(lu.LuaUnit.run())

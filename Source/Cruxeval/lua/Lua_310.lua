function f(strands)
    local subs = strands
    for i, j in ipairs(subs) do
        for _ = 1, math.floor(#j / 2) do
            subs[i] = string.sub(subs[i], -1) .. string.sub(subs[i], 2, -2) .. string.sub(subs[i], 1, 1)
        end
    end
    return table.concat(subs)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'__', '1', '.', '0', 'r0', '__', 'a_j', '6', '__', '6'}), '__1.00r__j_a6__6')
end

os.exit(lu.LuaUnit.run())

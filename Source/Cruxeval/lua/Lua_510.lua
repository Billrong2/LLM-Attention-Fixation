local function f(a, b, c, d, e)
    local key = d
    local num
    if a[key] then
        num = a[key]
        a[key] = nil
    end
    if b > 3 then
        return c
    else
        return num
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[7] = 'ii5p', [1] = 'o3Jwus', [3] = 'lot9L', [2] = '04g', [9] = 'Wjf', [8] = '5b', [0] = 'te6', [5] = 'flLO', [6] = 'jq', [4] = 'vfa0tW'}, 4, 'Wy', 'Wy', 1.0), 'Wy')
end

os.exit(lu.LuaUnit.run())

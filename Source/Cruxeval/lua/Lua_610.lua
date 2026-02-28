local function f(keys, value)
    local d = {}
    for i, k in ipairs(keys) do
        d[k] = value
    end
    
    local new_d = {}
    for i, k in ipairs(d) do
        if d[k] == d[i] then
            new_d[k] = d[k]
        end
    end
    return new_d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 1, 1}, 3), {})
end

os.exit(lu.LuaUnit.run())

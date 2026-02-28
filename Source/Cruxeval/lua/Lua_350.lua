function f(d)
    local size = next(d) and 0 or 1
    for _ in pairs(d) do size = size + 1 end
    local v = {}
    for i=1, size do v[i] = 0 end
    if size == 0 then
        return v
    end
    local keys = {}
    for k in pairs(d) do
        table.insert(keys, k)
    end
    table.sort(keys)
    for i=1, size do
        v[i] = d[keys[i]]
    end
    return v
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['a'] = 1, ['b'] = 2, ['c'] = 3}), {1, 2, 3})
end

os.exit(lu.LuaUnit.run())

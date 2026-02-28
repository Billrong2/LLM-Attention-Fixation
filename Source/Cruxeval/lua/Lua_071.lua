local function f(d, n)
    for i=1,n do
        local keys = {}
        for k in pairs(d) do table.insert(keys, k) end
        table.sort(keys)
        local key_to_remove = keys[#keys]
        local value_to_add = d[key_to_remove]
        d[key_to_remove] = nil
        d[value_to_add] = key_to_remove
    end
    return d
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = 2, [3] = 4, [5] = 6, [7] = 8, [9] = 10}, 1), {[1] = 2, [3] = 4, [5] = 6, [7] = 8, [10] = 9})
end

os.exit(lu.LuaUnit.run())

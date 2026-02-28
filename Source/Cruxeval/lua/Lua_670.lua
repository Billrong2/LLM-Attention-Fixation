local function f(a, b)
    local d = {}
    for i=1, #a do
        d[a[i]] = b[i]
    end
    table.sort(a, function(x, y) return d[x] > d[y] end)
    local result = {}
    for i=1, #a do
        table.insert(result, d[a[i]])
        d[a[i]] = nil
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'12', 'ab'}, {2, 2}), {2, 2})
end

os.exit(lu.LuaUnit.run())

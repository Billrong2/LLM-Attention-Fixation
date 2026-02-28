local function f(n)
    local values = { [0] = 3, [1] = 4.5, [2] = '-' }
    local res = {}
    for i, j in pairs(values) do
        if i % n ~= 2 then
            res[j] = math.floor(n / 2)
        end
    end
    local sorted_res = {}
    for k, _ in pairs(res) do
        table.insert(sorted_res, k)
    end
    table.sort(sorted_res)
    return sorted_res
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(12), {3, 4.5})
end

os.exit(lu.LuaUnit.run())

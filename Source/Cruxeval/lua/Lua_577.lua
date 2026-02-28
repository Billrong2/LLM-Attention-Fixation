local function f(items)
    local result = {}
    for i = 1, #items do
        local d = {}
        for j = 1, #items do
            if j ~= i then
                d[items[j][1]] = items[j][2]
            end
        end
        table.insert(result, d)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{1, 'pos'}}), {{}})
end

os.exit(lu.LuaUnit.run())

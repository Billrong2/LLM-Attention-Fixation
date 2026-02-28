function f(matrix)
    table.sort(matrix, function(a, b) return table.max(a) > table.max(b) end)
    for i, primary in ipairs(matrix) do
        table.sort(primary, function(a, b) return a > b end)
    end
    return matrix
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{1, 1, 1, 1}}), {{1, 1, 1, 1}})
end

os.exit(lu.LuaUnit.run())

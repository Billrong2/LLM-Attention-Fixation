local function f(a)
    if a == 0 then
        return {0}
    end
    local result = {}
    while a > 0 do
        table.insert(result, a % 10)
        a = math.floor(a / 10)
    end
    table.sort(result, function(a, b) return a > b end)
    return tonumber(table.concat(result, ''))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(0), {0})
end

os.exit(lu.LuaUnit.run())

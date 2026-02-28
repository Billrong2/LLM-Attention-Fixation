local function f(a, b)
    table.sort(a)
    table.sort(b, function(x, y) return x > y end)
    return {table.unpack(a), table.unpack(b)}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({666}, {}), {666})
end

os.exit(lu.LuaUnit.run())

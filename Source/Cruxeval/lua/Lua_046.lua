local function f(l, c)
    return table.concat(l, c)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'many', 'letters', 'asvsz', 'hello', 'man'}, ''), 'manylettersasvszhelloman')
end

os.exit(lu.LuaUnit.run())

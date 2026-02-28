local function f(lst)
    table.sort(lst)
    return {lst[1], lst[2], lst[3]}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 8, 1, 3, 0}), {0, 1, 3})
end

os.exit(lu.LuaUnit.run())

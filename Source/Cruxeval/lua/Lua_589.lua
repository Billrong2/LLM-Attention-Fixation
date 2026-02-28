local function f(num)
    table.insert(num, num[#num])
    return num
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-70, 20, 9, 1}), {-70, 20, 9, 1, 1})
end

os.exit(lu.LuaUnit.run())

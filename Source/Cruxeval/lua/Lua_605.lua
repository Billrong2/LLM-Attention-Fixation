local function f(nums)
    nums = {}
    return "quack"
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 5, 1, 7, 9, 3}), 'quack')
end

os.exit(lu.LuaUnit.run())

local function f(nums, sort_count)
    table.sort(nums)
    return {table.unpack(nums, 1, sort_count)}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 2, 3, 4, 5}, 1), {1})
end

os.exit(lu.LuaUnit.run())

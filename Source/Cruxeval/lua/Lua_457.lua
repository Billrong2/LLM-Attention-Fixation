local function f(nums)
    local count = {}
    for i = 1, #nums do
        table.insert(count, i)
    end
    for i = 1, #nums do
        table.remove(nums)
        if #count > 0 then
            table.remove(count, 1)
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 1, 7, 5, 6}), {})
end

os.exit(lu.LuaUnit.run())

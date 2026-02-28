local function f(nums)
    local count = 0
    while #nums > 0 do
        if count % 2 == 0 then
            table.remove(nums)
        else
            table.remove(nums, 1)
        end
        count = count + 1
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 2, 0, 0, 2, 3}), {})
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    local i = #nums
    while i >= 1 do
        if nums[i] % 2 == 0 then
            table.remove(nums, i)
        end
        i = i - 1
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 3, 3, 7}), {5, 3, 3, 7})
end

os.exit(lu.LuaUnit.run())

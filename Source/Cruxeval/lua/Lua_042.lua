local function f(nums)
    for i = #nums, 1, -1 do
        table.remove(nums, i)
    end
    
    for i, num in ipairs(nums) do
        table.insert(nums, i, num * 2)
    end
    
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({4, 3, 2, 1, 2, -1, 4, 2}), {})
end

os.exit(lu.LuaUnit.run())

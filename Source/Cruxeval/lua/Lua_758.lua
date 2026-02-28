local function f(nums)
    local reversed_nums = {}
    for i = #nums, 1, -1 do
        table.insert(reversed_nums, nums[i])
    end
    
    if reversed_nums == nums then
        return true
    end
    
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 3, 6, 2}), false)
end

os.exit(lu.LuaUnit.run())

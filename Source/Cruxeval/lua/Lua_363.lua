local function f(nums)
    table.sort(nums)
    local n = #nums
    local new_nums = {nums[math.floor(n/2) + 1]}
    
    if n % 2 == 0 then
        new_nums = {nums[n/2], nums[n/2 + 1]}
    end
    
    for i = 1, math.floor(n/2) do
        table.insert(new_nums, 1, nums[n-i+1])
        table.insert(new_nums, nums[i])
    end
    return new_nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1}), {1})
end

os.exit(lu.LuaUnit.run())

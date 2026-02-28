local function f(nums)
    local nums_filtered = {}
    for _, y in ipairs(nums) do
        if y > 0 then
            table.insert(nums_filtered, y)
        end
    end
    if #nums_filtered <= 3 then
        return nums_filtered
    end
    local reversed_nums = {}
    for i = #nums_filtered, 1, -1 do
        table.insert(reversed_nums, nums_filtered[i])
    end
    local half = math.floor(#reversed_nums/2)
    local nums_half = {}
    for i = 1, half do
        table.insert(nums_half, reversed_nums[i])
    end
    for i = 1, 5 do
        table.insert(nums_half, 0)
    end
    for i = half+1, #reversed_nums do
        table.insert(nums_half, reversed_nums[i])
    end
    return nums_half
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({10, 3, 2, 2, 6, 0}), {6, 2, 0, 0, 0, 0, 0, 2, 3, 10})
end

os.exit(lu.LuaUnit.run())

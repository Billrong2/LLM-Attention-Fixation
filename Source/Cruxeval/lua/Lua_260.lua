local function f(nums, start, k)
    local slice = {}
    for i = start + 1, start + k do
        table.insert(slice, nums[i])
    end
    for i = 1, #slice / 2 do
        local temp = slice[i]
        slice[i] = slice[#slice - i + 1]
        slice[#slice - i + 1] = temp
    end
    for i = start + 1, start + k do
        nums[i] = slice[i - start]
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4, 5, 6}, 4, 2), {1, 2, 3, 4, 6, 5})
end

os.exit(lu.LuaUnit.run())

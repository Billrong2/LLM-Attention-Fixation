local function f(nums)
    local m = nums[1]
    for i, num in ipairs(nums) do
        if num > m then
            m = num
        end
    end
    for i = 1, m do
        local i = 1
        local j = #nums
        while i < j do
            nums[i], nums[j] = nums[j], nums[i]
            i = i + 1
            j = j - 1
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({43, 0, 4, 77, 5, 2, 0, 9, 77}), {77, 9, 0, 2, 5, 77, 4, 0, 43})
end

os.exit(lu.LuaUnit.run())

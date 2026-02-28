local function f(nums, mos)
    for i, num in ipairs(mos) do
        for j, n in ipairs(nums) do
            if n == num then
                table.remove(nums, j)
                break
            end
        end
    end
    table.sort(nums)
    for i, num in ipairs(mos) do
        table.insert(nums, num)
    end
    for i = 1, #nums - 1 do
        if nums[i] > nums[i+1] then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 1, 2, 1, 4, 1}, {1}), false)
end

os.exit(lu.LuaUnit.run())

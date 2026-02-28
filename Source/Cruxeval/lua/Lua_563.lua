local function f(text1, text2)
    local nums = {}
    for i = 1, string.len(text2) do
        local count = 0
        for j = 1, string.len(text1) do
            if string.sub(text1, j, j) == string.sub(text2, i, i) then
                count = count + 1
            end
        end
        table.insert(nums, count)
    end
    local sum = 0
    for i, num in ipairs(nums) do
        sum = sum + num
    end
    return sum
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jivespdcxc', 'sx'), 2)
end

os.exit(lu.LuaUnit.run())

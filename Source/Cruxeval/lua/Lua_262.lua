function f(nums)
    local count = #nums
    local score = {[0] = "F", [1] = "E", [2] = "D", [3] = "C", [4] = "B", [5] = "A", [6] = ""}
    local result = {}
    for i = 1, count do
        table.insert(result, score[nums[i]])
    end
    return table.concat(result)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({4, 5}), 'BA')
end

os.exit(lu.LuaUnit.run())

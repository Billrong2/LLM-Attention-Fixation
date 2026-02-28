local function f(nums)
    local middle = math.floor(#nums / 2)
    local result = {}
    
    for i = middle + 1, #nums do
        table.insert(result, nums[i])
    end

    for i = 1, middle do
        table.insert(result, nums[i])
    end

    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1, 1}), {1, 1, 1})
end

os.exit(lu.LuaUnit.run())

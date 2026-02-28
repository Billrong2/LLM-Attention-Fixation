local function f(nums)
    local width = tonumber(nums[1])
    local result = {}
    for i = 2, #nums do
        local val = string.format("%0"..width.."d", tonumber(nums[i]))
        table.insert(result, val)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'1', '2', '2', '44', '0', '7', '20257'}), {'2', '2', '44', '0', '7', '20257'})
end

os.exit(lu.LuaUnit.run())

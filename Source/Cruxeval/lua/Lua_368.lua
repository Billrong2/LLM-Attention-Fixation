local function f(string, numbers)
    local arr = {}
    for i, num in ipairs(numbers) do
        local zfill_str = string.format("%0"..num.."d", tonumber(string))
        table.insert(arr, zfill_str)
    end
    return table.concat(arr, ' ')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('4327', {2, 8, 9, 2, 7, 1}), '4327 00004327 000004327 4327 0004327 4327')
end

os.exit(lu.LuaUnit.run())

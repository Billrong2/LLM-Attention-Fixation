local function f(s)
    local nums = string.gsub(s, "%D", "")
    if nums == '' then
        return 'none'
    end
    local max_num = -math.huge
    for num in nums:gmatch("%d+") do
        max_num = math.max(max_num, tonumber(num))
    end
    return tostring(max_num)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('01,001'), '1001')
end

os.exit(lu.LuaUnit.run())

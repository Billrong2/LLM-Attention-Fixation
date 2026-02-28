local function f(nums)
    local count = #nums
    if count == 0 then
        nums = {}
        for i=1, tonumber(table.remove(nums)) do
            table.insert(nums, 0)
        end
    elseif count % 2 == 0 then
        nums = {}
    else
        for i=1, count//2 do
            table.remove(nums, 1)
        end
    end
    return nums
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-6, -2, 1, -3, 0, 1}), {})
end

os.exit(lu.LuaUnit.run())

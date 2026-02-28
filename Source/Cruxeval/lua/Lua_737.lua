local function f(nums)
    local counts = 0
    for key, value in pairs(nums) do
        if tonumber(value) ~= nil then
            if counts == 0 then
                counts = counts + 1
            end
        end
    end
    return counts
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 6, 2, -1, -2}), 1)
end

os.exit(lu.LuaUnit.run())

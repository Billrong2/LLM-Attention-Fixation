local function f(nums)
    local digits = {}
    for i, num in ipairs(nums) do
        if type(num) == "number" or (type(num) == "string" and tonumber(num) ~= nil) then
            table.insert(digits, num)
        end
    end
    for i, v in ipairs(digits) do
        digits[i] = tonumber(v)
    end
    return digits
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 6, '1', '2', 0}), {0, 6, 1, 2, 0})
end

os.exit(lu.LuaUnit.run())

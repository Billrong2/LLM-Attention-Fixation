local function f(digits)
    local i, j = 1, #digits
    while i < j do
        digits[i], digits[j] = digits[j], digits[i]
        i = i + 1
        j = j - 1
    end
    if #digits < 2 then
        return digits
    end
    for i = 1, #digits, 2 do
        if i + 1 <= #digits then
            digits[i], digits[i+1] = digits[i+1], digits[i]
        end
    end
    return digits
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2}), {1, 2})
end

os.exit(lu.LuaUnit.run())

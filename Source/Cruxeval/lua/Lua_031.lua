local function f(string)
    local upper = 0
    for i = 1, string:len() do
        local c = string:sub(i, i)
        if string.byte(c) >= 65 and string.byte(c) <= 90 then
            upper = upper + 1
        end
    end
    return upper * ((upper % 2 == 0) and 2 or 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('PoIOarTvpoead'), 8)
end

os.exit(lu.LuaUnit.run())

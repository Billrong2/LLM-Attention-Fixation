local function f(num)
    local letter = 1
    local pattern = '1234567890'
    for i = 1, #pattern do
        num = string.gsub(num, pattern:sub(i, i), '')
        if #num == 0 then break end
        num = string.sub(num, letter + 1) .. string.sub(num, 1, letter)
        letter = letter + 1
    end
    return num
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bwmm7h'), 'mhbwm')
end

os.exit(lu.LuaUnit.run())

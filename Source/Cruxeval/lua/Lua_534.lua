local function f(sequence, value)
    local i = math.max(string.find(sequence, value) - math.floor(#sequence / 3), 1)
    local result = ''
    for j = i, #sequence do
        local v = string.sub(sequence, j, j)
        if v == '+' then
            result = result .. value
        else
            result = result .. string.sub(sequence, i + j - 1, i + j - 1)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hosu', 'o'), 'hosu')
end

os.exit(lu.LuaUnit.run())

local function f(float_number)
    local number = tostring(float_number)
    local dot = string.find(number, '%.')
    if dot ~= nil then
        local before_dot = string.sub(number, 1, dot-1)
        local after_dot = string.sub(number, dot+1)
        return before_dot .. '.' .. after_dot .. string.rep('0', 2 - #after_dot)
    else
        return number .. '.00'
    end
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(3.121), '3.121')
end

os.exit(lu.LuaUnit.run())

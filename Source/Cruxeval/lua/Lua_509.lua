local function f(value, width)
    if value >= 0 then
        return string.format("%0"..width.."d", value)
    elseif value < 0 then
        return '-'..string.format("%0"..width.."d", -value)
    end
    return ''
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(5, 1), '5')
end

os.exit(lu.LuaUnit.run())

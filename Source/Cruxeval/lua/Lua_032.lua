local function f(s, sep)
    local reverse = {}
    for e in string.gmatch(s, "([^"..sep.."]+)") do
        table.insert(reverse, '*'..e)
    end
    local reversed_reverse = {}
    for i = #reverse, 1, -1 do
        table.insert(reversed_reverse, reverse[i])
    end
    return table.concat(reversed_reverse, ';')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('volume', 'l'), '*ume;*vo')
end

os.exit(lu.LuaUnit.run())

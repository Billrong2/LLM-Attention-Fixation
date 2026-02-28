local function f(text, froms)
    local pattern = "^["..froms.."]*(.-)["..froms.."]*$"
    local _,_,trimmed = text:find(pattern)
    return trimmed
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('0 t 1cos ', 'st 0\t\n  '), '1co')
end

os.exit(lu.LuaUnit.run())

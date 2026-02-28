local function f(str, toget)
    if string.sub(str, 1, string.len(toget)) == toget then
        return string.sub(str, string.len(toget) + 1)
    else
        return str
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('fnuiyh', 'ni'), 'fnuiyh')
end

os.exit(lu.LuaUnit.run())

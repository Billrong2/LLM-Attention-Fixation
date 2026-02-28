local function f(txt, alpha)
    table.sort(txt)
    if alpha == txt[1] then
        return txt
    else
        return {table.unpack(txt, 1, #txt)}
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'8', '9', '7', '4', '3', '2'}, '9'), {'2', '3', '4', '7', '8', '9'})
end

os.exit(lu.LuaUnit.run())

local function f(s)
    return string.upper(s)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1'), 'JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1')
end

os.exit(lu.LuaUnit.run())

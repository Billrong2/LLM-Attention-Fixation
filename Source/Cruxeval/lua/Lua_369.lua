local function f(var)
    if var:match("^%d+$") then
        return "int"
    elseif var:match("^%d+%.?%d*$") then
        return "float"
    elseif var:gsub("%s", "") == "" then
        return "str"
    elseif #var == 1 then
        return "char"
    else
        return "tuple"
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(' 99 777'), 'tuple')
end

os.exit(lu.LuaUnit.run())

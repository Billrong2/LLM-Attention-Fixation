local function f(text, value)
    return text:gsub("^" .. value:lower(), "")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('coscifysu', 'cos'), 'cifysu')
end

os.exit(lu.LuaUnit.run())

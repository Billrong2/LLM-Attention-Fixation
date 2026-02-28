local function f(name)
    if string.lower(name) == name then
        return string.upper(name)
    else
        return string.lower(name)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Pinneaple'), 'pinneaple')
end

os.exit(lu.LuaUnit.run())

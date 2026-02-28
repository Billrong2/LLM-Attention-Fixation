local function f(string)
    if string:upper() == string then
        return string:lower()
    elseif string:lower() == string then
        return string:upper()
    end
    return string
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('cA'), 'cA')
end

os.exit(lu.LuaUnit.run())

local function f(string, substring)
    while string:sub(1, #substring) == substring do
        string = string:sub(#substring + 1, #string)
    end
    return string
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('', 'A'), '')
end

os.exit(lu.LuaUnit.run())

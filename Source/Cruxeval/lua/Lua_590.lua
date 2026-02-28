local function f(text)
    for i=10, 1, -1 do
        text = string.gsub(text, "^" .. i, "")
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('25000   $'), '5000   $')
end

os.exit(lu.LuaUnit.run())

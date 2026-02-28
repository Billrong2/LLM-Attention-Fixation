local function f(text)
    if string.match(text, "^[%a_][%w_]*$") then
        return text:gsub("%D", "")
    else
        return text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('816'), '816')
end

os.exit(lu.LuaUnit.run())

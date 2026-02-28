local function f(text)
    local result = ''
    for i = string.len(text), 1, -1 do
        result = result .. string.sub(text, i, i)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('was,'), ',saw')
end

os.exit(lu.LuaUnit.run())

local function f(text, new_value, index)
    local old_value = string.sub(text, index + 1, index + 1)
    local result = string.gsub(text, old_value, new_value, 1)
    return result
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('spain', 'b', 4), 'spaib')
end

os.exit(lu.LuaUnit.run())

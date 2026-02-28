local function f(text)
    return text:gsub('\\"', '"')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Because it intrigues them'), 'Because it intrigues them')
end

os.exit(lu.LuaUnit.run())

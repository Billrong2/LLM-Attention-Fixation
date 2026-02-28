local function f(text)
    return text:find("-") == string.len(text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('---123-4'), false)
end

os.exit(lu.LuaUnit.run())

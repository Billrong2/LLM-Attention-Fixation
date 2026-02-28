local function f(postcode)
    return postcode:sub(postcode:find('C'), -1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ED20 CW'), 'CW')
end

os.exit(lu.LuaUnit.run())

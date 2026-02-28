local function f(text, use)
    return string.gsub(text, use, '')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Chris requires a ride to the airport on Friday.', 'a'), 'Chris requires  ride to the irport on Fridy.')
end

os.exit(lu.LuaUnit.run())

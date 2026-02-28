local function f(text, value)
    local left, right = string.match(text, "(.*)" .. value .. "(.*)")
    return right .. left
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('difkj rinpx', 'k'), 'j rinpxdif')
end

os.exit(lu.LuaUnit.run())

local function f(cart)
    while #cart > 5 do
        cart[#cart] = nil
    end
    return cart
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

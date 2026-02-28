local function f(price, product)
    local inventory = {'olives', 'key', 'orange'}
    if inventory[product] == nil then
        return price
    else
        price = price * 0.85
        table.remove(inventory, product)
    end
    return price
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(8.5, 'grapes'), 8.5)
end

os.exit(lu.LuaUnit.run())

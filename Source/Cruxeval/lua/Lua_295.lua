local function f(fruits)
    if fruits[#fruits] == fruits[1] then
        return {'no'}
    else
        table.remove(fruits, 1)
        table.remove(fruits, #fruits)
        table.remove(fruits, 1)
        table.remove(fruits, #fruits)
        return fruits
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'apple', 'apple', 'pear', 'banana', 'pear', 'orange', 'orange'}), {'pear', 'banana', 'pear'})
end

os.exit(lu.LuaUnit.run())

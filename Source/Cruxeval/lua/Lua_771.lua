local function f(items)
    local odd_positioned = {}
    items = {table.unpack(items)}
    while #items > 0 do
        local position = 1
        local min_value = items[1]
        for i = 2, #items do
            if items[i] < min_value then
                min_value = items[i]
                position = i
            end
        end
        table.remove(items, position)
        local item = table.remove(items, position)
        table.insert(odd_positioned, item)
    end
    return odd_positioned
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4, 5, 6, 7, 8}), {2, 4, 6, 8})
end

os.exit(lu.LuaUnit.run())

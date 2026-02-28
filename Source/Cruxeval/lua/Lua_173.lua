local function f(list_x)
    local item_count = #list_x
    local new_list = {}
    for i=1, item_count do
        table.insert(new_list, table.remove(list_x))
    end
    return new_list
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 8, 6, 8, 4}), {4, 8, 6, 8, 5})
end

os.exit(lu.LuaUnit.run())

local function f(items, item)
    while items[#items] == item do
        table.remove(items)
    end
    table.insert(items, item)
    return #items
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'bfreratrrbdbzagbretaredtroefcoiqrrneaosf'}, 'n'), 2)
end

os.exit(lu.LuaUnit.run())

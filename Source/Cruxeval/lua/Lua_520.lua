local function f(album_sales)
    while #album_sales ~= 1 do
        table.insert(album_sales, table.remove(album_sales, 1))
    end
    return album_sales[1]
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6}), 6)
end

os.exit(lu.LuaUnit.run())

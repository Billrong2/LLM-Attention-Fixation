local function f(lst)
    lst = {}
    for i=1,(#lst)+1 do
        table.insert(lst, 1)
    end
    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'a', 'c', 'v'}), {1})
end

os.exit(lu.LuaUnit.run())

local function f(lists)
    lists[2] = {}
    for i, v in ipairs(lists[1]) do
        table.insert(lists[2], v)
    end
    return lists[1]
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{395, 666, 7, 4}, {}, {4223, 111}}), {395, 666, 7, 4})
end

os.exit(lu.LuaUnit.run())

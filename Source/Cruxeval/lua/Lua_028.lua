local function f(mylist)
    local revl = {}
    for i = #mylist, 1, -1 do
        table.insert(revl, mylist[i])
    end
    table.sort(mylist, function(a, b) return a > b end)
    return table.concat(mylist, ",") == table.concat(revl, ",")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 8}), true)
end

os.exit(lu.LuaUnit.run())

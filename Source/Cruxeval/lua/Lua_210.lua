local function f(n, m, num)
    local x_list = {}
    for i=n,m do
        table.insert(x_list, i)
    end
    local j = 0
    while true do
        j = (j + num) % #x_list + 1
        if x_list[j] % 2 == 0 then
            return x_list[j]
        end
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(46, 48, 21), 46)
end

os.exit(lu.LuaUnit.run())

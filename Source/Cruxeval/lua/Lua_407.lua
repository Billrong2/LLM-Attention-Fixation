local function f(s)
    while #s > 1 do
        for i = 1, #s do
            s[i] = nil
        end
        table.insert(s, #s)
    end
    return table.remove(s)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 1, 2, 3}), 0)
end

os.exit(lu.LuaUnit.run())

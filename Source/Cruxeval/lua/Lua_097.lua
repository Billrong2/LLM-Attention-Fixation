function f(lst)
    for i, v in ipairs(lst) do
        if v == 3 then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({2, 0}), true)
end

os.exit(lu.LuaUnit.run())

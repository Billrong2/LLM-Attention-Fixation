local function f(lst)
    local new = {}
    local i = #lst
    for _=1, #lst do
        if i%2 ~= 0 then
            table.insert(new, -lst[i])
        else
            table.insert(new, lst[i])
        end
        i = i - 1
    end
    return new
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 7, -1, -3}), {-3, 1, 7, -1})
end

os.exit(lu.LuaUnit.run())

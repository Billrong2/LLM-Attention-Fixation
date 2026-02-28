function f(lst)
    local res = {}
    for i=1, #lst do
        if lst[i] % 2 == 0 then
            table.insert(res, lst[i])
        end
    end

    local copy = {}
    for i=1, #lst do
        table.insert(copy, lst[i])
    end

    return copy
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4}), {1, 2, 3, 4})
end

os.exit(lu.LuaUnit.run())

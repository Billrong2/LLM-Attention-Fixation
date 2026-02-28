local function f(lst)
    local original = {}
    for i = 1, #lst do
        table.insert(original, lst[i])
    end

    while #lst > 1 do
        table.remove(lst)
        for i = 1, #lst do
            table.remove(lst, i)
        end
    end

    lst = {}
    for i = 1, #original do
        table.insert(lst, original[i])
    end

    if #lst > 0 then
        table.remove(lst, 1)
    end

    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

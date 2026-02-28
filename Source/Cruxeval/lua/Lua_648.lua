local function f(list1, list2)
    local l = {}
    for i=1, #list1 do
        l[i] = list1[i]
    end
    while #l > 0 do
        local found = false
        for i=1, #list2 do
            if l[#l] == list2[i] then
                found = true
                break
            end
        end
        if found then
            table.remove(l)
        else
            return l[#l]
        end
    end
    return 'missing'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 4, 5, 6}, {13, 23, -5, 0}), 6)
end

os.exit(lu.LuaUnit.run())

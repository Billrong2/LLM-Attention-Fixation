local function f(lst)
    for i = #lst, 2, -1 do
        for j = 1, i - 1 do
            if lst[j] > lst[j + 1] then
                lst[j], lst[j + 1] = lst[j + 1], lst[j]
            end
        end
    end
    table.sort(lst)
    return lst
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({63, 0, 1, 5, 9, 87, 0, 7, 25, 4}), {0, 0, 1, 4, 5, 7, 9, 25, 63, 87})
end

os.exit(lu.LuaUnit.run())

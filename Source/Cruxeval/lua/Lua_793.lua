local function f(lst, start, _end)
    local count = 0
    for i = start, _end - 1 do
        for j = i, _end - 1 do
            if lst[i + 1] ~= lst[j + 1] then
                count = count + 1
            end
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 4, 3, 2, 1}, 0, 3), 3)
end

os.exit(lu.LuaUnit.run())

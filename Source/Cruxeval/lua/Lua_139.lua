local function f(first, second)
    if #first < 10 or #second < 10 then
        return 'no'
    end
    for i = 1, 5 do
        if first[i] ~= second[i] then
            return 'no'
        end
    end
    for _, value in ipairs(second) do
        table.insert(first, value)
    end
    return first
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 1}, {1, 1, 2}), 'no')
end

os.exit(lu.LuaUnit.run())

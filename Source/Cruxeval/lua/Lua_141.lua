local function f(li)
    local result = {}
    for i, v in ipairs(li) do
        local count = 0
        for _, val in ipairs(li) do
            if val == v then
                count = count + 1
            end
        end
        table.insert(result, count)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'k', 'x', 'c', 'x', 'x', 'b', 'l', 'f', 'r', 'n', 'g'}), {1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1})
end

os.exit(lu.LuaUnit.run())

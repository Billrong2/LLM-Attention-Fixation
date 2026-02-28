local function f(num)
    local initial = {1}
    local total = initial
    for _ = 1, num do
        local new_total = {1}
        for i = 1, #total - 1 do
            table.insert(new_total, total[i] + total[i + 1])
        end
        total = new_total
        table.insert(initial, total[#total])
    end
    local sum = 0
    for _, v in ipairs(initial) do
        sum = sum + v
    end
    return sum
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(3), 4)
end

os.exit(lu.LuaUnit.run())

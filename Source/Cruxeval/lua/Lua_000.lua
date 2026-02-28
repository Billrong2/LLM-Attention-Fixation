function f(nums)
    local output = {}
    for i, n in ipairs(nums) do
        local count = 0
        for _, v in ipairs(nums) do
            if v == n then
                count = count + 1
            end
        end
        table.insert(output, {count, n})
    end
    table.sort(output, function(a, b) return a[1] > b[1] end)
    return output
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1, 3, 1, 3, 1}), {{4, 1}, {4, 1}, {4, 1}, {4, 1}, {2, 3}, {2, 3}})
end

os.exit(lu.LuaUnit.run())

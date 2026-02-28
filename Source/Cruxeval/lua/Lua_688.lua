local function f(nums)
    local l = {}
    for i, num in ipairs(nums) do
        local exists = false
        for j, value in ipairs(l) do
            if value == num then
                exists = true
                break
            end
        end
        if not exists then
            table.insert(l, num)
        end
    end
    return l
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 1, 9, 0, 2, 0, 8}), {3, 1, 9, 0, 2, 8})
end

os.exit(lu.LuaUnit.run())

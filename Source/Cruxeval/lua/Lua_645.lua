local function table_count(t, val)
    local count = 0
    for i, v in pairs(t) do
        if v == val then
            count = count + 1
        end
    end
    return count
end

local function table_index(t, val)
    for i, v in ipairs(t) do
        if v == val then
            return i
        end
    end
end

local function f(nums, target)
    if table_count(nums, 0) ~= 0 then
        return 0
    elseif table_count(nums, target) < 3 then
        return 1
    else
        return table_index(nums, target)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1, 1, 2}, 3), 1)
end

os.exit(lu.LuaUnit.run())

local function f(nums)
    local asc = {}
    for i = 1, #nums do
        table.insert(asc, nums[i])
    end

    local desc = {}
    for i = #asc, 1, -1 do
        table.insert(desc, asc[i])
    end

    local mid = math.floor(#asc / 2)
    local desc_part = {}
    for i = 1, mid do
        table.insert(desc_part, desc[i])
    end

    local result = {}
    for i = 1, #desc_part do
        table.insert(result, desc_part[i])
    end
    for i = 1, #asc do
        table.insert(result, asc[i])
    end
    for i = 1, #desc_part do
        table.insert(result, desc_part[i])
    end

    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

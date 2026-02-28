function f(base_list, nums)
    for i=1, #nums do
        table.insert(base_list, nums[i])
    end

    local res = {}
    for i=1, #base_list do
        table.insert(res, base_list[i])
    end

    for i=1, #nums do
        table.insert(res, res[#res - #nums + i])
    end

    return res
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({9, 7, 5, 3, 1}, {2, 4, 6, 8, 0}), {9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6})
end

os.exit(lu.LuaUnit.run())

local function f(nums, rmvalue)
    local res = {}
    for i = 1, #nums do
        table.insert(res, nums[i])
    end

    while true do
        local index = nil
        for i = 1, #res do
            if res[i] == rmvalue then
                index = i
                break
            end
        end

        if index then
            local popped = table.remove(res, index)
            if popped ~= rmvalue then
                table.insert(res, popped)
            end
        else
            break
        end
    end

    return res
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({6, 2, 1, 1, 4, 1}, 5), {6, 2, 1, 1, 4, 1})
end

os.exit(lu.LuaUnit.run())

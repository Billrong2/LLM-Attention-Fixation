function f(nums)
    local verdict = function(x) return x < 2 end
    local res = {}
    for _, x in ipairs(nums) do
        if x ~= 0 then
            table.insert(res, x)
        end
    end
    local result = {}
    for _, x in ipairs(res) do
        table.insert(result, {x, verdict(x)})
    end
    if #result > 0 then
        return result
    else
        return 'error - no numbers or all zeros!'
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 3, 0, 1}), {{3, false}, {1, true}})
end

os.exit(lu.LuaUnit.run())

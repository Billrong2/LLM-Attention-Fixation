local function f(query, base)
    local net_sum = 0
    for key, val in pairs(base) do
        if string.sub(key, 1, 1) == query and string.len(key) == 3 then
            net_sum = net_sum - val
        elseif string.sub(key, -1) == query and string.len(key) == 3 then
            net_sum = net_sum + val
        end
    end
    return net_sum
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a', {}), 0)
end

os.exit(lu.LuaUnit.run())

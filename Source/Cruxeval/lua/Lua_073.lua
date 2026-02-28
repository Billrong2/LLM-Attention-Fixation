local function f(row)
    local count_ones = 0
    local count_zeros = 0
    for i=1, #row do
        if row:sub(i,i) == '1' then
            count_ones = count_ones + 1
        end
        if row:sub(i,i) == '0' then
            count_zeros = count_zeros + 1
        end
    end
    return {count_ones, count_zeros}
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('100010010'), {3, 6})
end

os.exit(lu.LuaUnit.run())

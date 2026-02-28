local function f(s, p)
    local arr = {}
    for w in string.gmatch(s, "([^%s]+)") do
        table.insert(arr, w)
    end
    local part_one, part_two, part_three = 0, 0, 0
    for i = 1, #arr do
        if arr[i] == p then
            part_two = #arr[i]
            for j = i-1, 1, -1 do
                part_one = part_one + 1
            end
            for k = i+1, #arr do
                part_three = part_three + 1
            end
            break
        end
    end
    if part_one >= 2 and part_two <= 2 and part_three >= 2 then
        local reversed_part_one = ''
        for i = part_one, 1, -1 do
            reversed_part_one = reversed_part_one .. arr[i]
        end
        local reversed_part_three = ''
        for i = part_two + part_one + 1, #arr do
            reversed_part_three = arr[i] .. reversed_part_three
        end
        return (reversed_part_one .. arr[part_one + 1] .. arr[part_one + 2] .. reversed_part_three .. '#')
    end
    return (s)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qqqqq', 'qqq'), 'qqqqq')
end

os.exit(lu.LuaUnit.run())

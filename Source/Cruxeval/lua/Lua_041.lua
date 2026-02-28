local function f(array, values)
    array = reverse_table(array)
    for _, value in ipairs(values) do
        local mid = math.floor(#array / 2) + 1
        table.insert(array, mid, value)
    end
    array = reverse_table(array)
    return array
end

-- helper function to reverse a table
function reverse_table(t)
    local i, j = 1, #t
    while i < j do
        t[i], t[j] = t[j], t[i]
        i = i + 1
        j = j - 1
    end
    return t
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({58}, {21, 92}), {58, 92, 21})
end

os.exit(lu.LuaUnit.run())

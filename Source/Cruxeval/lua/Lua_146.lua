local function f(single_digit)
    local result = {}
    for c = 1, 10 do
        if c ~= single_digit then
            table.insert(result, c)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(5), {1, 2, 3, 4, 6, 7, 8, 9, 10})
end

os.exit(lu.LuaUnit.run())

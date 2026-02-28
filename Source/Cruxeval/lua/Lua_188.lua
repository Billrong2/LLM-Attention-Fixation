local function f(strings)
    local new_strings = {}
    for i, string in ipairs(strings) do
        local first_two = string:sub(1, 2)
        if first_two:sub(1, 1) == 'a' or first_two:sub(1, 1) == 'p' then
            table.insert(new_strings, first_two)
        end
    end
    return new_strings
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'a', 'b', 'car', 'd'}), {'a'})
end

os.exit(lu.LuaUnit.run())

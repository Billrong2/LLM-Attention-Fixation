local function f(names)
    if #names == 0 then
        return ""
    end
    local smallest = names[1]
    for i = 2, #names do
        if names[i] < smallest then
            smallest = names[i]
        end
    end
    table.remove(names, smallest)
    return table.concat(smallest)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), '')
end

os.exit(lu.LuaUnit.run())

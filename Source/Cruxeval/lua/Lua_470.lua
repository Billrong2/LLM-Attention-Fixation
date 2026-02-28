local function f(number)
    local transl = {A = 1, B = 2, C = 3, D = 4, E = 5}
    local result = {}
    for key, value in pairs(transl) do
        if value % number == 0 then
            table.insert(result, key)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(2), {'B', 'D'})
end

os.exit(lu.LuaUnit.run())

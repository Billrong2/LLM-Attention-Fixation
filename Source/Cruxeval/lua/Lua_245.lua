local function f(alphabet, s)
    local a = {}
    for i = 1, #alphabet do
        local x = alphabet:sub(i, i)
        if string.upper(x) == x then
            table.insert(a, x)
        end
    end
    if string.upper(s) == s then
        table.insert(a, 'all_uppercased')
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abcdefghijklmnopqrstuvwxyz', 'uppercased # % ^ @ ! vz.'), {})
end

os.exit(lu.LuaUnit.run())

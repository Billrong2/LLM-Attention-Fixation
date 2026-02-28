local function f(dict)
    local even_keys = {}
    for key, _ in pairs(dict) do
        if key % 2 == 0 then
            table.insert(even_keys, key)
        end
    end
    return even_keys
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[4] = 'a'}), {4})
end

os.exit(lu.LuaUnit.run())

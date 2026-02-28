local function f(dictionary)
    local a = {}
    for key, value in pairs(dictionary) do
        if key % 2 ~= 0 then
            a['$' .. tostring(key)] = value
            dictionary[key] = nil
        end
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

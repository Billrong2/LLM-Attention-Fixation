local function f(d, get_ary)
    local result = {}
    for i, key in ipairs(get_ary) do
        table.insert(result, d[key])
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[3] = 'swims like a bull'}, {3, 2, 5}), {'swims like a bull', None, None})
end

os.exit(lu.LuaUnit.run())

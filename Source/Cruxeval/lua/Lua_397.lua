local function f(ls)
    local result = {}
    for i, v in ipairs(ls) do
        result[v] = 0
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'x', 'u', 'w', 'j', '3', '6'}), {['x'] = 0, ['u'] = 0, ['w'] = 0, ['j'] = 0, ['3'] = 0, ['6'] = 0})
end

os.exit(lu.LuaUnit.run())

local function f(tap_hierarchy)
    local hierarchy = {}
    for _, gift in ipairs(tap_hierarchy) do
        hierarchy[gift] = nil
    end
    return hierarchy
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'john', 'doe', 'the', 'john', 'doe'}), {['d'] = None, ['o'] = None, ['e'] = None})
end

os.exit(lu.LuaUnit.run())

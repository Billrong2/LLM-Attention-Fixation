local function f(commands)
    local d = {}
    for i, c in pairs(commands) do
        for k, v in pairs(c) do
            d[k] = v
        end
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{['brown'] = 2}, {['blue'] = 5}, {['bright'] = 4}}), {['brown'] = 2, ['blue'] = 5, ['bright'] = 4})
end

os.exit(lu.LuaUnit.run())

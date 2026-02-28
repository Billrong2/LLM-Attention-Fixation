local function f(update, starting)
    local d = {}
    for k, v in pairs(starting) do
        d[k] = v
    end
    for k, v in pairs(update) do
        if d[k] then
            d[k] = d[k] + v
        else
            d[k] = v
        end
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, {['desciduous'] = 2}), {['desciduous'] = 2})
end

os.exit(lu.LuaUnit.run())

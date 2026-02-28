local function f(d, count)
    for i=1, count do
        if next(d) == nil then
            break
        end
        d[next(d)] = nil
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, 200), {})
end

os.exit(lu.LuaUnit.run())

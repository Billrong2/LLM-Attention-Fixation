local function f(obj)
    for k, v in pairs(obj) do
        if v >= 0 then
            obj[k] = -v
        end
    end
    return obj
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['R'] = 0, ['T'] = 3, ['F'] = -6, ['K'] = 0}), {['R'] = 0, ['T'] = -3, ['F'] = -6, ['K'] = 0})
end

os.exit(lu.LuaUnit.run())

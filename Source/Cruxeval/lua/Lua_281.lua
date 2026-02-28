local function f(c, index, value)
    c[index] = value
    if value >= 3 then
        c['message'] = 'xcrWt'
    else
        c['message'] = nil
    end
    return c
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = 2, [3] = 4, [5] = 6, ['message'] = 'qrTHo'}, 8, 2), {[1] = 2, [3] = 4, [5] = 6, [8] = 2})
end

os.exit(lu.LuaUnit.run())

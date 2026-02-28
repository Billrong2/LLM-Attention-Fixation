local function f(d, rm)
    local res = {}
    for k, v in pairs(d) do
        res[k] = v
    end
    for i, k in ipairs(rm) do
        if res[k] then
            res[k] = nil
        end
    end
    return res
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['1'] = 'a', [1] = 'a', [1] = 'b', ['1'] = 'b'}, {1}), {['1'] = 'b'})
end

os.exit(lu.LuaUnit.run())

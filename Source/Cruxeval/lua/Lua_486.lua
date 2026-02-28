local function f(dic)
    local dic_op = {}
    for key, val in pairs(dic) do
        dic_op[key] = val * val
    end
    return dic_op
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = 1, [2] = 2, [3] = 3}), {[1] = 1, [2] = 4, [3] = 9})
end

os.exit(lu.LuaUnit.run())

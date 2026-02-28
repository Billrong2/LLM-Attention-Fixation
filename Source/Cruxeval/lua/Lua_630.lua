local function f(original, string)
    local temp = {}
    for a, b in pairs(string) do
        temp[b] = a
    end
    for k, v in pairs(original) do
        temp[k] = v
    end
    return temp
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = -9, [0] = -7}, {[1] = 2, [0] = 3}), {[1] = -9, [0] = -7, [2] = 1, [3] = 0})
end

os.exit(lu.LuaUnit.run())

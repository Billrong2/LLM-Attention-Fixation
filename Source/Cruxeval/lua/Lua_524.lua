local function f(dict0)
    local new = {}
    for k, v in pairs(dict0) do
        table.insert(new, k)
    end
    table.sort(new)
    for i = 1, #new-1 do
        dict0[new[i]] = i - 1
    end
    return dict0
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[2] = 5, [4] = 1, [3] = 5, [1] = 3, [5] = 1}), {[2] = 1, [4] = 3, [3] = 2, [1] = 0, [5] = 1})
end

os.exit(lu.LuaUnit.run())

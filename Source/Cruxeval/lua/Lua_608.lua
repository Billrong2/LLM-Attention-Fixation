local function f(aDict)
    local newDict = {}
    for k, v in pairs(aDict) do
        newDict[v] = k
    end
    return newDict
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = 1, [2] = 2, [3] = 3}), {[1] = 1, [2] = 2, [3] = 3})
end

os.exit(lu.LuaUnit.run())

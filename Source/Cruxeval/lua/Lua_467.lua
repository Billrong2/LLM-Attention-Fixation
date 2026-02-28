local function f(nums)
    local copy = {}
    for k, v in pairs(nums) do
        copy[k] = v
    end
    local newDict = {}
    for k, v in pairs(copy) do
        newDict[k] = #v
    end
    return newDict
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())

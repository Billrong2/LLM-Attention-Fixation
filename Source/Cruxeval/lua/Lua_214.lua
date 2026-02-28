local function f(sample)
    local i = -1
    while string.find(sample, '/', i+1, true) ~= nil do
        i = string.find(sample, '/', i+1, true)
    end
    return string.find(sample, '/', 0, i, true) - 1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('present/here/car%2Fwe'), 7)
end

os.exit(lu.LuaUnit.run())

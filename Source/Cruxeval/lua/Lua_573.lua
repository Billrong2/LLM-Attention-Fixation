local function f(string, prefix)
    if string:sub(1, #prefix) == prefix then
        return string:sub(#prefix + 1)
    end
    return string
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Vipra', 'via'), 'Vipra')
end

os.exit(lu.LuaUnit.run())

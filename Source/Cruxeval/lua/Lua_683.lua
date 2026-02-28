local function f(dict1, dict2)
    local result = {}
    for key, value in pairs(dict1) do
        result[key] = value
    end
    for key, value in pairs(dict2) do
        result[key] = value
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['disface'] = 9, ['cam'] = 7}, {['mforce'] = 5}), {['disface'] = 9, ['cam'] = 7, ['mforce'] = 5})
end

os.exit(lu.LuaUnit.run())

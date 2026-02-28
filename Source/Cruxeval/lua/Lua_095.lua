local function f(zoo)
    local result = {}
    for k, v in pairs(zoo) do
        result[v] = k
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['AAA'] = 'fr'}), {['fr'] = 'AAA'})
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local result_list = {'3', '3', '3', '3'}
    if next(result_list) ~= nil then
        result_list = {}
    end
    return string.len(text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mrq7y'), 5)
end

os.exit(lu.LuaUnit.run())

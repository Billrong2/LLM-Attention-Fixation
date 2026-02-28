local function f(text)
    local values = {}
    for value in string.gmatch(text, "%S+") do
        table.insert(values, value)
    end
    return string.format("${first}y, ${second}x, ${third}r, ${fourth}p", values[1], values[2], values[3], values[4])
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('python ruby c javascript'), '${first}y, ${second}x, ${third}r, ${fourth}p')
end

os.exit(lu.LuaUnit.run())

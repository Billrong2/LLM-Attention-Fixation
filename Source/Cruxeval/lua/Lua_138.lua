local function f(text, chars)
    local listchars = {}
    for i = 1, #chars do
        table.insert(listchars, chars:sub(i, i))
    end
    local first = table.remove(listchars)
    for _, i in ipairs(listchars) do
        local index = string.find(text, i)
        text = text:sub(1, index - 1) .. i .. text:sub(index + 1)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('tflb omn rtt', 'm'), 'tflb omn rtt')
end

os.exit(lu.LuaUnit.run())

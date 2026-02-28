local function f(text, space)
    if space < 0 then
        return text
    end
    return text .. string.rep(" ", math.floor((#text + space) / 2) - #text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('sowpf', -7), 'sowpf')
end

os.exit(lu.LuaUnit.run())

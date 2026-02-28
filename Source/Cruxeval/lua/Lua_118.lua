local function f(text, chars)
    local num_applies = 2
    local extra_chars = ''
    for i=1, num_applies do
        extra_chars = extra_chars .. chars
        text = string.gsub(text, extra_chars, '')
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('zbzquiuqnmfkx', 'mk'), 'zbzquiuqnmfkx')
end

os.exit(lu.LuaUnit.run())

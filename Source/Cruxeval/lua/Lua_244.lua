local function f(text, symbols)
    local count = 0
    if symbols ~= nil and symbols ~= "" then
        count = string.len(symbols)
        text = string.rep(text, count)
    end
    local paddedText = string.rep(" ", count*2) .. text
    return string.sub(paddedText, 1, #paddedText - 2)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('', 'BC1ty'), '        ')
end

os.exit(lu.LuaUnit.run())

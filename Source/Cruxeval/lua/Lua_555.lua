local function f(text, tabstop)
    text = string.gsub(text, '\n', '_____')
    text = string.gsub(text, '\t', string.rep(' ', tabstop))
    text = string.gsub(text, '_____', '\n')
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('odes\tcode\twell', 2), 'odes  code  well')
end

os.exit(lu.LuaUnit.run())

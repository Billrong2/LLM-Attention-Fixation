local function f(text)
    local trans = {['"'] = '9', ["'"] = '8', ['>'] = '3', ['<'] = '3'}
    return text:gsub("[\"'><]", function(x) return trans[x] end)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Transform quotations"\nnot into numbers.'), 'Transform quotations9\nnot into numbers.')
end

os.exit(lu.LuaUnit.run())

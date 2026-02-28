local function f(text, tab_size)
    return string.gsub(text, "\t", string.rep(" ", tab_size))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a', 100), 'a')
end

os.exit(lu.LuaUnit.run())

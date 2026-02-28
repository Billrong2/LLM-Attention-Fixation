local function f(input_string, spaces)
    return string.gsub(input_string, "\t", string.rep(" ", spaces))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a\\tb', 4), 'a\\tb')
end

os.exit(lu.LuaUnit.run())

local function f(a_str, prefix)
    if not a_str:sub(1, #prefix) == prefix then
        return prefix .. a_str
    else
        return a_str
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abc', 'abcd'), 'abc')
end

os.exit(lu.LuaUnit.run())

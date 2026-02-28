local function f(s, suffix)
    if suffix == '' then
        return s
    end
    while string.sub(s, -string.len(suffix)) == suffix do
        s = string.sub(s, 1, -string.len(suffix) - 1)
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ababa', 'ab'), 'ababa')
end

os.exit(lu.LuaUnit.run())

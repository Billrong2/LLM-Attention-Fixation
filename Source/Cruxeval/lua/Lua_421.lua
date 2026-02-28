local function f(s, n)
    if string.len(s) < n then
        return s
    else
        return string.sub(s, n+1)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('try.', 5), 'try.')
end

os.exit(lu.LuaUnit.run())

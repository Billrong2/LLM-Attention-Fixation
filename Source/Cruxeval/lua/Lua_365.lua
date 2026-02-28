local function f(n, s)
    if string.sub(s, 1, string.len(n)) == n then
        local pre, _ = string.match(s, "(.-)"..n)
        return pre .. n .. string.sub(s, string.len(n) + 1)
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('xqc', 'mRcwVqXsRDRb'), 'mRcwVqXsRDRb')
end

os.exit(lu.LuaUnit.run())

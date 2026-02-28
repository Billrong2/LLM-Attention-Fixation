local function f(a, b)
    if a < b then
        return {b, a}
    end
    return {a, b}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ml', 'mv'), {'mv', 'ml'})
end

os.exit(lu.LuaUnit.run())

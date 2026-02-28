local function f(t)
    local a, _, b = string.match(t, "^(.+)-(.+)$")
    if a == nil or b == nil then
        a, b = t, ""
    end
    if string.len(b) == string.len(a) then
        return 'imbalanced'
    end
    return a .. b
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('fubarbaz'), 'fubarbaz')
end

os.exit(lu.LuaUnit.run())

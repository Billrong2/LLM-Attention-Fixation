local function f(s)
    if string.match(s, "%a+") then
        return "yes"
    elseif s == "" then
        return "str is empty"
    else
        return "no"
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Boolean'), 'yes')
end

os.exit(lu.LuaUnit.run())

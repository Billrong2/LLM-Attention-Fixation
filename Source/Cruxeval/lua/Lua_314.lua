local function f(text)
    if string.find(text, ',', 1, true) then
        local before, after = string.match(text, "([^,]*),(.*)")
        return after .. ' ' .. before
    else
        return ',' .. string.match(text, " %s*([^ ]+)") .. ' 0'
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('244, 105, -90'), ' 105, -90 244')
end

os.exit(lu.LuaUnit.run())

local function f(s)
    local count = 0
    for i = 1, #s do
        local c = s:sub(i,i)
        if s:sub(1, i - 1):find(c) ~= s:sub(i + 1):find(c) then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abca dea ead'), 10)
end

os.exit(lu.LuaUnit.run())

local function f(letters)
    local count = 0
    for i = 1, #letters do
        if string.match(string.sub(letters, i, i), "%d") then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dp ef1 gh2'), 2)
end

os.exit(lu.LuaUnit.run())

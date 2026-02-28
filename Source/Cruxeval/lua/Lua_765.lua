local function f(text)
    local count = 0
    for i=1, #text do
        if string.match(text:sub(i, i), "%d") then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('so456'), 3)
end

os.exit(lu.LuaUnit.run())

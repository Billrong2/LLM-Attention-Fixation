local function f(sentence)
    for i = 1, #sentence do
        local c = sentence:sub(i, i)
        if not c:match("[%z\1-\127\194-\244][\128-\191]*") then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('1z1z1'), true)
end

os.exit(lu.LuaUnit.run())

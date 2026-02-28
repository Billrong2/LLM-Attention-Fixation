local function f(text)
    local a = 0
    if string.find(text, text:sub(1, 1), 2) ~= nil then
        a = a + 1
    end
    for i = 1, string.len(text) - 1 do
        if string.find(text, text:sub(i, i), i + 1) ~= nil then
            a = a + 1
        end
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('3eeeeeeoopppppppw14film3oee3'), 18)
end

os.exit(lu.LuaUnit.run())

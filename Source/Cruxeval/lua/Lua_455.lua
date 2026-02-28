local function f(text)
    local uppers = 0
    for i = 1, #text do
        local c = text:sub(i, i)
        if c:upper() == c then
            uppers = uppers + 1
        end
    end
    return uppers >= 10 and text:upper() or text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('?XyZ'), '?XyZ')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local b = true
    for i = 1, #text do
        if string.match(text:sub(i, i), '%d') then
            b = true
        else
            b = false
            break
        end
    end
    return b
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('-1-3'), false)
end

os.exit(lu.LuaUnit.run())

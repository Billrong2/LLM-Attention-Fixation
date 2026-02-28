local function f(text)
    local result = ''
    local i = string.len(text) - 1
    while i >= 0 do
        local c = string.sub(text, i+1, i+1)
        if string.match(c, "%a") then
            result = result .. c
        end
        i = i - 1
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('102x0zoq'), 'qozx')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local chars = {}
    for i = 1, #text do
        local c = text:sub(i, i)
        if tonumber(c) then
            table.insert(chars, c)
        end
    end
    return table.concat(chars, ""):reverse()
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('--4yrw 251-//4 6p'), '641524')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local t = text
    for i in text:gmatch(".") do
        text = text:gsub(i, "")
    end
    return tostring(#text) .. t
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ThisIsSoAtrocious'), '0ThisIsSoAtrocious')
end

os.exit(lu.LuaUnit.run())

local function f(s)
    local count = 0
    local digits = ""
    for i = 1, #s do
        local c = s:sub(i, i)
        if tonumber(c) then
            count = count + 1
            digits = digits .. c
        end
    end
    return {digits, count}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qwfasgahh329kn12a23'), {'3291223', 7})
end

os.exit(lu.LuaUnit.run())

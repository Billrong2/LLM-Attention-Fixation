local function f(s)
    local result = ""
    for i = 1, #s do
        if string.sub(s, i, i):find("%s") then
            result = result .. string.sub(s, i, i)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('\ngiyixjkvu\n\r\r \x0crgjuo'), '\n\n\r\r \x0c')
end

os.exit(lu.LuaUnit.run())

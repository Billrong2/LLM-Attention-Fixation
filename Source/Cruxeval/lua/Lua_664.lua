local function f(tags)
    local resp = ""
    for key, value in pairs(tags) do
        resp = resp .. key .. " "
    end
    return resp
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['3'] = '3', ['4'] = '5'}), '3 4 ')
end

os.exit(lu.LuaUnit.run())

local function f(text, prefix)
    if string.sub(text, 1, string.len(prefix)) == prefix then
        text = string.sub(text, string.len(prefix) + 1)
    end
    text = text:gsub("^%l", string.upper)
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qdhstudentamxupuihbuztn', 'jdm'), 'Qdhstudentamxupuihbuztn')
end

os.exit(lu.LuaUnit.run())

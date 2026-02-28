local function f(text)
    text = text:gsub("^%s*(.-)%s*$", "%1")
    if text == '' then
        return #text
    else
        return nil
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(' \t '), 0)
end

os.exit(lu.LuaUnit.run())

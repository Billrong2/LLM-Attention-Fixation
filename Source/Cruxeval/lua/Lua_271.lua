local function f(text, c)
    local ls = {string.byte(text, 1, #text)}
    if string.find(text, c, 1, true) == nil then
        error("Text has no " .. c)
    end
    table.remove(ls, string.find(text, c, 1, true))
    return string.char(table.unpack(ls))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('uufhl', 'l'), 'uufh')
end

os.exit(lu.LuaUnit.run())

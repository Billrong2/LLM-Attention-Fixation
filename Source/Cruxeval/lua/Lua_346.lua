local function f(filename)
    local suffix = string.match(filename, "%.(.-)$")
    local f2 = filename .. suffix:reverse()
    return f2:sub(-#suffix) == suffix
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('docs.doc'), false)
end

os.exit(lu.LuaUnit.run())

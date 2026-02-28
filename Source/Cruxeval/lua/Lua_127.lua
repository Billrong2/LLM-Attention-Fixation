local function f(text)
    local s = {}
    for line in text:gmatch("([^\n]*)\n?") do
        table.insert(s, line)
    end
    return #s
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('145\n\n12fjkjg'), 3)
end

os.exit(lu.LuaUnit.run())

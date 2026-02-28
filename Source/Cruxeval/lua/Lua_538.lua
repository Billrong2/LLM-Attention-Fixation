local function f(text, width)
    local output = string.sub(text, 1, width)
    while string.len(output) < width do
        output = 'z' .. output .. 'z'
    end
    return string.sub(output, 1, width)
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('0574', 9), 'zzz0574zz')
end

os.exit(lu.LuaUnit.run())

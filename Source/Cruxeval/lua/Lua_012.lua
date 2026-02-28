local function f(s, x)
    local count = 0
    while string.sub(s, 1, #x) == x and count < #s - #x do
        s = string.sub(s, #x+1)
        count = count + #x
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('If you want to live a happy life! Daniel', 'Daniel'), 'If you want to live a happy life! Daniel')
end

os.exit(lu.LuaUnit.run())

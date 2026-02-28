local function f(string)
    return string:gsub('needles', 'haystacks')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wdeejjjzsjsjjsxjjneddaddddddefsfd'), 'wdeejjjzsjsjjsxjjneddaddddddefsfd')
end

os.exit(lu.LuaUnit.run())

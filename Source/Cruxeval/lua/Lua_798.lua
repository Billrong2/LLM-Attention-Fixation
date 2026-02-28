local function f(text, pre)
    if string.sub(text, 1, #pre) ~= pre then
        return text
    end
    return string.sub(text, #pre + 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('@hihu@!', '@hihu'), '@!')
end

os.exit(lu.LuaUnit.run())

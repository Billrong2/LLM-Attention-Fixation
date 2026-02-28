local function f(prefix, text)
    if string.sub(text, 1, string.len(prefix)) == prefix then
        return text
    else
        return prefix .. text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mjs', 'mjqwmjsqjwisojqwiso'), 'mjsmjqwmjsqjwisojqwiso')
end

os.exit(lu.LuaUnit.run())

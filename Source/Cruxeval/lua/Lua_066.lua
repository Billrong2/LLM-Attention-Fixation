local function f(text, prefix)
    local prefix_length = string.len(prefix)
    if string.sub(text, 1, prefix_length) == prefix then
        return string.sub(text, (prefix_length - 1) // 2 + 1, (prefix_length + 1) // 2 * -1 + 1):reverse()
    else
        return text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('happy', 'ha'), '')
end

os.exit(lu.LuaUnit.run())

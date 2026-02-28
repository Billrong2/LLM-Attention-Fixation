local function f(text, char, min_count)
    local count = string.len(string.gsub(text, "[^" .. char .. "]", ""))
    if count < min_count then
        return string.upper(text)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wwwwhhhtttpp', 'w', 3), 'wwwwhhhtttpp')
end

os.exit(lu.LuaUnit.run())

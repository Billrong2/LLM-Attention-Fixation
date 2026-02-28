local function f(haystack, needle)
    local i = string.find(haystack, needle)
    while i do
        if string.sub(haystack, i) == needle then
            return i
        end
        i = string.find(haystack, needle, i + 1)
    end
    return -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('345gerghjehg', '345'), -1)
end

os.exit(lu.LuaUnit.run())

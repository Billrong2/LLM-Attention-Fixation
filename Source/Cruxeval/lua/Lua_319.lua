local function f(needle, haystack)
    local count = 0
    while string.find(haystack, needle, 1, true) do
        haystack = string.gsub(haystack, needle, '', 1)
        count = count + 1
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a', 'xxxaaxaaxx'), 4)
end

os.exit(lu.LuaUnit.run())

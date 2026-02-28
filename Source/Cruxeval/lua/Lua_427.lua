local function f(s)
    local count = string.len(s) - 1
    local reverse_s = string.reverse(s)
    while count > 0 and not string.find(reverse_s:sub(1, count):gsub("..", ""), "sea") do
        count = count - 1
        reverse_s = string.sub(reverse_s, 1, count)
    end
    return string.sub(reverse_s, count + 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('s a a b s d s a a s a a'), '')
end

os.exit(lu.LuaUnit.run())

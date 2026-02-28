local function f(text)
    local ans = ''
    while text ~= '' do
        local x, sep, rest = string.match(text, '([^%(]*)(%()(.*)')
        ans = x .. sep:gsub('%(', '|') .. ans
        ans = ans .. rest:sub(1, 1) .. ans
        text = rest:sub(2)
    end
    return ans
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(''), '')
end

os.exit(lu.LuaUnit.run())

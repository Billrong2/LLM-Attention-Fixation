local function f(s)
    local count = {}
    for i = 1, #s do
        local char = s:sub(i, i):lower()
        if char:match('%a') then
            count[char] = (count[char] or 0) + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('FSA'), {['f'] = 1, ['s'] = 1, ['a'] = 1})
end

os.exit(lu.LuaUnit.run())

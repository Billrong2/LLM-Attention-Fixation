local function f(text, letter)
    local counts = {}
    for i = 1, string.len(text) do
        local char = string.sub(text, i, i)
        counts[char] = (counts[char] or 0) + 1
    end
    return counts[letter] or 0
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('za1fd1as8f7afasdfam97adfa', '7'), 2)
end

os.exit(lu.LuaUnit.run())

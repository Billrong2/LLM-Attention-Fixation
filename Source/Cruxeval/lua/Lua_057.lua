local function f(text)
    text = string.upper(text)
    local count_upper = 0
    for i = 1, string.len(text) do
        local char = string.sub(text, i, i)
        if string.upper(char) == char then
            count_upper = count_upper + 1
        else
            return 'no'
        end
    end
    return math.floor(count_upper / 2)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ax'), 1)
end

os.exit(lu.LuaUnit.run())

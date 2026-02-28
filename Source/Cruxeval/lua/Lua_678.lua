local function f(text)
    local freq = {}
    text = string.lower(text)
    for i = 1, string.len(text) do
        local c = string.sub(text, i, i)
        if freq[c] then
            freq[c] = freq[c] + 1
        else
            freq[c] = 1
        end
    end
    return freq
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('HI'), {['h'] = 1, ['i'] = 1})
end

os.exit(lu.LuaUnit.run())

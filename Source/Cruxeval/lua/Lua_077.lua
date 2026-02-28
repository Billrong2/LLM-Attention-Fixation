local function f(text, character)
    local _, last_pos = string.find(text, character, -1)
    if last_pos then
        local subject = string.sub(text, last_pos)
        local cnt = 0
        for i = 1, string.len(text) do
            if string.sub(text, i, i) == character then
                cnt = cnt + 1
            end
        end
        return subject:rep(cnt)
    end
    return ""
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('h ,lpvvkohh,u', 'i'), '')
end

os.exit(lu.LuaUnit.run())

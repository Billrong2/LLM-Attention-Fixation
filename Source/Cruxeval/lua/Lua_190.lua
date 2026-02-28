local function f(text)
    local short = ''
    for i = 1, string.len(text) do
        local c = string.sub(text, i, i)
        if string.match(c, "%l") then
            short = short .. c
        end
    end
    return short
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('980jio80jic kld094398IIl '), 'jiojickldl')
end

os.exit(lu.LuaUnit.run())

local function f(text)
    local x = 0
    if string.match(text, "%l+") then
        for i = 1, string.len(text) do
            local c = string.sub(text, i, i)
            if tonumber(c) and tonumber(c) < 90 then
                x = x + 1
            end
        end
    end
    return x
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('591237865'), 0)
end

os.exit(lu.LuaUnit.run())

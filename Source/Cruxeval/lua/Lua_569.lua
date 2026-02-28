local function f(txt)
    local coincidences = {}
    for i = 1, string.len(txt) do
        local c = string.sub(txt, i, i)
        if coincidences[c] then
            coincidences[c] = coincidences[c] + 1
        else
            coincidences[c] = 1
        end
    end
    local total = 0
    for _, v in pairs(coincidences) do
        total = total + v
    end
    return total
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('11 1 1'), 6)
end

os.exit(lu.LuaUnit.run())

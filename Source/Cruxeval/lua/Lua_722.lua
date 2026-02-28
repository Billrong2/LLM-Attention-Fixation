local function f(text)
    local out = ""
    for i = 1, string.len(text) do
        local char = string.sub(text, i, i)
        if string.match(char, "%u") then
            out = out .. string.lower(char)
        else
            out = out .. string.upper(char)
        end
    end
    return out
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(',wPzPppdl/'), ',WpZpPPDL/')
end

os.exit(lu.LuaUnit.run())

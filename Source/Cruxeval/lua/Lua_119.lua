local function f(text)
    local result = ""
    for i = 1, string.len(text) do
        if i % 2 == 1 then
            result = result .. string.upper(string.sub(text, i, i))
        else
            result = result .. string.sub(text, i, i)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('vsnlygltaw'), 'VsNlYgLtAw')
end

os.exit(lu.LuaUnit.run())

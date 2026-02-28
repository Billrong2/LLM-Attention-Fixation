local function f(text)
    local a = {}
    for i=1, string.len(text) do
        if not tonumber(string.sub(text, i, i)) then
            table.insert(a, string.sub(text, i, i))
        end
    end
    return table.concat(a)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('seiq7229 d27'), 'seiq d')
end

os.exit(lu.LuaUnit.run())

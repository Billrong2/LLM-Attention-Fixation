local function f(text)
    local t = {}
    for i = 1, #text do
        table.insert(t, string.sub(text, i, i))
    end
    table.remove(t, #t // 2 + 1)
    table.insert(t, string.lower(text))
    return table.concat(t, ':')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Rjug nzufE'), 'R:j:u:g: :z:u:f:E:rjug nzufe')
end

os.exit(lu.LuaUnit.run())

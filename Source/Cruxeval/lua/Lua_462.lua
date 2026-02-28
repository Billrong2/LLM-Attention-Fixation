local function f(text, value)
    local length = string.len(text)
    local letters = {}
    for i = 1, string.len(text) do
        table.insert(letters, text:sub(i, i))
    end
    if not string.find(table.concat(letters), value, 1, true) then
        value = letters[1]
    end
    return string.rep(value, length)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ldebgp o', 'o'), 'oooooooo')
end

os.exit(lu.LuaUnit.run())

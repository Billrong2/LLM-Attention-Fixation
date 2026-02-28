local function f(text, characters)
    local character_list = {}
    for i = 1, string.len(characters) do
        table.insert(character_list, string.sub(characters, i, i))
    end
    table.insert(character_list, ' ')
    table.insert(character_list, '_')

    local i = 1
    while i <= string.len(text) and string.find(table.concat(character_list), string.sub(text, i, i), 1, true) do
        i = i + 1
    end

    return string.sub(text, i)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('2nm_28in', 'nm'), '2nm_28in')
end

os.exit(lu.LuaUnit.run())

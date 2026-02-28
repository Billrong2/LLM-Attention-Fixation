local function f(text, char)
    local index = text:match('(.*' .. char .. ')'):len()
    local result = {}
    for i = 1, string.len(text) do
        table.insert(result, string.sub(text, i, i))
    end
    while index > 1 do
        result[index] = result[index-1]
        result[index-1] = char
        index = index - 2
    end
    return table.concat(result)
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qpfi jzm', 'j'), 'jqjfj zm')
end

os.exit(lu.LuaUnit.run())

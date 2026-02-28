local function split(str, delimiter)
    local result = {}
    local from  = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(str, from, delim_from-1))
        from  = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end
    table.insert(result, string.sub(str, from))
    return result
end

local function f(text, char)
    return table.concat(split(text, char), ' ')
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a', 'a'), ' ')
end

os.exit(lu.LuaUnit.run())

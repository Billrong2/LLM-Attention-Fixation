local function f(test, sep, maxsplit)
    sep = sep or ' '
    maxsplit = maxsplit or -1
    local success, result = pcall(string.gmatch, test, "[^" .. sep .. "]+")
    if not success then
        return {test}
    end
    local parts = {}
    for part in result do
        table.insert(parts, part)
    end
    return parts
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ab cd', 'x', 2), {'ab cd'})
end

os.exit(lu.LuaUnit.run())

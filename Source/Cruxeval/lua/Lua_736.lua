local function f(text, insert)
    local whitespaces = {'\t', '\r', '\v', ' ', '\f', '\n'}
    local clean = ''
    for i = 1, string.len(text) do
        local char = string.sub(text, i, i)
        if table.contains(whitespaces, char) then
            clean = clean .. insert
        else
            clean = clean .. char
        end
    end
    return clean
end

-- Add the 'contains' function to the table.
table.contains = function(table, value)
    for k, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('pi wa', 'chi'), 'pichiwa')
end

os.exit(lu.LuaUnit.run())

local function f(text, ch)
    local result = {}
    for line in text:gmatch("[^\n]+") do
        if string.len(line) > 0 and string.sub(line, 1, 1) == ch then
            table.insert(result, string.lower(line))
        else
            table.insert(result, string.upper(line))
        end
    end
    return table.concat(result, "\n")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('t\nza\na', 't'), 't\nZA\nA')
end

os.exit(lu.LuaUnit.run())

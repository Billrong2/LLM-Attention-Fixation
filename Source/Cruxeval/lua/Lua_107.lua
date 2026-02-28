local function f(text)
    local result = {}
    for i = 1, string.len(text) do
        local char = string.sub(text, i, i)
        if not string.match(char, "[%z\1-\127\194-\244][\128-\191]*") then
            return false
        elseif string.match(char, "%w") then
            table.insert(result, string.upper(char))
        else
            table.insert(result, char)
        end
    end
    return table.concat(result)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ua6hajq'), 'UA6HAJQ')
end

os.exit(lu.LuaUnit.run())

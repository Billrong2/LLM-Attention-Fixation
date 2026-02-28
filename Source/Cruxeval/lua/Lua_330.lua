local function f(text)
    local ans = {}
    for i = 1, #text do
        local char = text:sub(i, i)
        if tonumber(char) then
            table.insert(ans, char)
        else
            table.insert(ans, ' ')
        end
    end
    return table.concat(ans)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('m4n2o'), ' 4 2 ')
end

os.exit(lu.LuaUnit.run())

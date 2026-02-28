local function f(text)
    local result = {}
    for i = 1, #text do
        local ch = text:sub(i, i)
        if ch == string.lower(ch) then
            goto continue
        end
        if #text - i < text:reverse():find(string.lower(ch)) then
            table.insert(result, ch)
        end
        ::continue::
    end
    return table.concat(result)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ru'), '')
end

os.exit(lu.LuaUnit.run())

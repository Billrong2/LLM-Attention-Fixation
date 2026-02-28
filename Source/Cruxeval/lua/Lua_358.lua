local function f(text, value)
    local indexes = {}
    for i = 1, string.len(text) do
        if string.sub(text, i, i) == value and (i == 1 or string.sub(text, i-1, i-1) ~= value) then
            table.insert(indexes, i-1)
        end
    end
    if #indexes % 2 == 1 then
        return text
    else
        return string.sub(text, indexes[1]+2, indexes[#indexes])
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('btrburger', 'b'), 'tr')
end

os.exit(lu.LuaUnit.run())

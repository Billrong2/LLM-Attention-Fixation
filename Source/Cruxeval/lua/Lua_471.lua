local function f(val, text)
    local indices = {}
    for index=1, #text do
        if text:sub(index, index) == val then
            table.insert(indices, index)
        end
    end
    if #indices == 0 then
        return -1
    else
        return indices[1]
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('o', 'fnmart'), -1)
end

os.exit(lu.LuaUnit.run())

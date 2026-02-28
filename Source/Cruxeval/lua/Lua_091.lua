local function f(s)
    local seen = ''
    local result = {}
    for i = 1, #s do
        local c = s:sub(i, i)
        if not seen:find(c) then
            table.insert(result, c)
            seen = seen .. c
        end
    end
    return result
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('12ab23xy'), {'1', '2', 'a', 'b', '3', 'x', 'y'})
end

os.exit(lu.LuaUnit.run())

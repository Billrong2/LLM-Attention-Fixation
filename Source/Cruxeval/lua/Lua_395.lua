local function f(s)
    for i = 1, #s do
        local char = s:sub(i, i)
        if char:match('%d') then
            if char == '0' then
                return i
            else
                return i - 1
            end
        elseif char == '0' then
            return -1
        end
    end
    return -1
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('11'), 0)
end

os.exit(lu.LuaUnit.run())

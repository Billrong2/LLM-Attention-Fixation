local function f(text, lower, upper)
    local count = 0
    local new_text = {}
    for i = 1, #text do
        local char = text:sub(i, i)
        if char:match('%d') then
            char = lower
        else
            char = upper
        end
        if char == 'p' or char == 'C' then
            count = count + 1
        end
        table.insert(new_text, char)
    end
    return {count, table.concat(new_text)}
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('DSUWeqExTQdCMGpqur', 'a', 'x'), {0, 'xxxxxxxxxxxxxxxxxx'})
end

os.exit(lu.LuaUnit.run())
